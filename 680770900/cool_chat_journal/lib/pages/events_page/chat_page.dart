import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/chat.dart';
import '../../model/event.dart';
import 'app_bar_builder.dart';
import 'bottom_panel.dart';
import 'delete_dialog.dart';
import 'event_view.dart';

class ChatPage extends StatefulWidget {  

  final Chat chat;

  const ChatPage(this.chat);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Map<int, bool> _selectedFlag = {};
  late final AppBarBuilder _appBarBuilder;
  bool _showFavorites = false;
  bool _isEditMode = false;

  bool _isSelectionMode() => _countSelectedEvents() != 0;
  bool _isHasImage() => _selectedFlag.keys.
    where((key) => _selectedFlag[key] == true).
    where((key) => widget.chat.events[key].isImage).isNotEmpty;

  void _addTextEvent(String eventText) {
    setState(() {
      widget.chat.events.add(
        Event(
          content: eventText,
          changeTime: DateTime.now(),
        ),
      );
    });
  }

  Future<ImageSource?> _showImageDialog() {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Choose image source'),
        actions: [
          ElevatedButton(
            child: const Text('Camera'), 
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          ElevatedButton(
            child: const Text('Gallery'), 
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ]
      ),
    );
  }

  Future<void> _uploadImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
            
    if (image != null) {
      widget.chat.events.add(
        Event(
          content: image.path,
          isImage: true,
          changeTime: DateTime.now(),
        )
      );
    }
  }

  void _addImage() {
    _showImageDialog().then((source) async {
      if (source != null) {
        await _uploadImage(source);
      }
      
      setState(() {});
    });
  }

  void _editEvent(String eventText) {
    final index = _selectedFlag.keys.
      firstWhere((i) => _selectedFlag[i] == true);

    final sourceEvent = widget.chat.events[index];
    
    setState(() {
      widget.chat.events[index] = sourceEvent.copyWith(
        content: eventText, 
      );
    });

    _isEditMode = false;
    _onResetSelection();
  }

  void _onTap(bool isSelected, int index) {
    if (_isSelectionMode()) {
       _onLongPress(isSelected, index);
    } else {
      final event = widget.chat.events[index];
      setState(() {
        widget.chat.events[index] = event.copyWith(
          isFavorite: !event.isFavorite
        );
      });
    }
  }

  void _onLongPress(bool isSelected, int index) {
    setState(() {
      _showFavorites = false;
      _selectedFlag[index] = !isSelected;
    });
  }

  void _onResetSelection() {
    setState(() {
      for (final i in _selectedFlag.keys) {
        _selectedFlag[i] = false;
      }
    });
  }

  void _onRemoval() {
    showModalBottomSheet<bool>(
      context: context,
      builder: (context) => DeleteDialog(_countSelectedEvents()),  
    ).then((value) {
      if (value == true) {
        final events = widget.chat.events;
        for (var i = 0; i < widget.chat.events.length; i++) {
          if (_selectedFlag[i] == true) {
            events.remove(events[i]);
          }
        }
      }
    }).then(
      (value) => _onResetSelection()
    );
  }

  void _onBackButton() {
    Navigator.pop(context);
  }

  void _onShowFavorite() {
    setState(() => _showFavorites = !_showFavorites);
  }

  void _onMarkFavorites() {
    final events = widget.chat.events;
    for (var i = 0; i < widget.chat.events.length; i++) {
      if (_selectedFlag[i] == true) {
        final event = events[i];

        events[i] = event.copyWith(
          isFavorite: !event.isFavorite,
        );
      }
    }
    _onResetSelection();
  }

  void _onEditAction() {
    setState(() {
      _isEditMode = true;
    });
  }

  void _onCloseEditMode() {
    setState(() {
      _isEditMode = false;
    });

    _onResetSelection();
  }

  void _onCopyAction() {
    var copyText = '';

    _selectedFlag.keys.where(
      (key) => _selectedFlag[key] == true && !widget.chat.events[key].isImage
    ).map(
      (key) => copyText += copyText.isNotEmpty 
        ? '${widget.chat.events[key].content}'
        : '\n'
    );

    Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );

    _onResetSelection();
  }

  int _countSelectedEvents() {
    return _selectedFlag.values.where((value) => value).length;
  }

  Widget _createEventsView() {
    if (widget.chat.events.isNotEmpty) {
      
      List<Event> events;
      if (_showFavorites) {
        events = widget.chat.events.
          where((event) => event.isFavorite).toList();
      } else {
        events = widget.chat.events;
      }

      if (events.isEmpty) {
        events = widget.chat.events;
      }

      events = events.reversed.toList();
     
      return ListView.builder(
        reverse: true,
        itemCount: events.length,
        itemBuilder: (_, index) {
          _selectedFlag[index] = _selectedFlag[index] ?? false;  
          var isSelected = _selectedFlag[index]!;

          return EventView(
            event: events[index],
            isSelected: isSelected,
            onTap: () => _onTap(isSelected, index),
            onLongPress: () => _onLongPress(isSelected, index),
          );
        }
      ); 
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: _WelcomeMessage(title: widget.chat.name),
      );
    }
  }

  Widget _createScaffoldBody() {
    var index = _selectedFlag.keys.
      firstWhere((i) => _selectedFlag[i] == true, orElse: () => -1);

    return Column(
      children: [
        Expanded(
          child: _createEventsView(),
        ),

        if (!_isSelectionMode())
          BottomPanel(
            onSendImage: _addImage,
            onSendText: _addTextEvent,
          ),

        if (
          _isEditMode &&
          index != -1 &&
          !widget.chat.events[index].isImage
        )
          BottomPanel(
            textFieldValue: widget.chat.events[index].content,
            onSendText: _editEvent,
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _appBarBuilder = AppBarBuilder(
      title: widget.chat.name,
      onBackButton: _onBackButton,
      onResetSelection: _onResetSelection,
      onShowFavorite: _onShowFavorite,
      onRemoval: _onRemoval,
      onMarkFavorites: _onMarkFavorites,
      onEditAction: _onEditAction,
      onCloseEditMode: _onCloseEditMode,
      onCopyAction: _onCopyAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder.build(
        countSelected: _countSelectedEvents(),
        showFavorites: _showFavorites,
        isEditMode: _isEditMode,
        isHasImage: _isHasImage(),
      ),

      body: _createScaffoldBody(),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  
  final String title;

  const _WelcomeMessage({required this.title});
  
  @override
  Widget build(BuildContext context) {
    var titleMessage = 'This is the page where you can track '
      'everything about "$title"';

    return Card(
      child: ListTile(
        title: Text(
          titleMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}