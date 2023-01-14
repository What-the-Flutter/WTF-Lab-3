import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../theme/colors.dart';
import '../widgets/event_box.dart';
import '../widgets/info_box.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final _fieldText = TextEditingController();
  bool _isFavorite = false, _isSelectedMode = false, _isEditMode = false;
  late List<Event> _events;
  final List<int> _selectedItemIndexes = [];
  final _bookMark = Icons.bookmark_border_outlined;
  late AppBar appBar;

  @override
  void initState() {
    super.initState();
    _events = widget.chat.events;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: Scaffold(
        appBar: _isSelectedMode ? _buildSelectedAppBar() : _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.chat.events.isNotEmpty
                  ? _buildMessageList(size)
                  : InfoBox(size: size, mainTitle: widget.chat.title),
              _getInputBox(size),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.chat.title),
      centerTitle: true,
      actions: <Widget>[
        _createToolIcon(
          icon: Icons.search,
          onPressed: _lookForWords,
        ),
        _createToolIcon(
          horizontal: 6,
          icon: _isFavorite ? Icons.bookmark : _bookMark,
          color: _isFavorite ? Colors.yellow : null,
          onPressed: _showFavorites,
        ),
      ],
    );
  }

  void _lookForWords() {}

  void _showFavorites() {
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        _events =
            widget.chat.events.where((element) => element.isFavorite).toList();
      } else {
        _events = widget.chat.events;
      }
    });
  }

  AppBar _buildSelectedAppBar() {
    return AppBar(
      leading: _createToolIcon(icon: Icons.close, onPressed: _disableSelect),
      actions: <Widget>[
        Expanded(
          child: Align(
            alignment: const Alignment(0, 0.15),
            child: Text(
              '${_selectedItemIndexes.length}',
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        _createEditIcon(),
        _createToolIcon(icon: Icons.copy, onPressed: _copyText),
        _createToolIcon(icon: _bookMark, onPressed: _changeFavoriteStatus),
        _createToolIcon(icon: Icons.delete, onPressed: _deleteMessage),
      ],
    );
  }

  Padding _createEditIcon() {
    final icon = Icons.edit;
    if (_selectedItemIndexes.length == 1 && !_isEditMode) {
      return _createToolIcon(icon: icon, onPressed: _turnOnEditMode);
    } else {
      return _createToolIcon(icon: icon, color: Colors.transparent);
    }
  }

  Padding _createToolIcon({
    double horizontal = 6.0,
    required IconData icon,
    Color? color,
    void Function()? onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontal),
      child: IconButton(
        icon: Icon(icon, size: 24, color: color),
        onPressed: onPressed,
      ),
    );
  }

  void _disableSelect() {
    for (var i in _selectedItemIndexes) {
      _events[i].isSelected = false;
    }

    _fieldText.clear();
    _isEditMode = false;

    _finishEditMode();
  }

  void _turnOnEditMode() {
    setState(() {
      _isEditMode = true;
      _fieldText.text = _events[_selectedItemIndexes.last].message;
    });
  }

  void _turnOffEditMode() {
    _isEditMode = false;
    _events[_selectedItemIndexes.last].message = _fieldText.text;
    _disableSelect();
  }

  void _copyText() {
    _selectedItemIndexes.sort();
    String? text;

    for (var i in _selectedItemIndexes) {
      final message = _events[i].message;
      if (text == null) {
        text = '$message\n\n';
      } else {
        text += '$message\n\n';
      }
    }

    Clipboard.setData(ClipboardData(text: text));

    _disableSelect();
  }

  void _changeFavoriteStatus() {
    for (var i in _selectedItemIndexes) {
      _events[i].isFavorite = !_events[i].isFavorite;
    }

    _disableSelect();
  }

  void _deleteMessage() {
    _selectedItemIndexes.sort();

    var shift = 0;
    for (var i in _selectedItemIndexes) {
      _events.removeAt(i + shift--);
    }

    _finishEditMode();
  }

  void _finishEditMode() {
    setState(() {
      _isSelectedMode = false;
      _selectedItemIndexes.clear();
    });
  }

  Expanded _buildMessageList(Size size) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: _events.length,
        itemBuilder: (_, i) {
          final index = _events.length - 1 - i;
          return InkWell(
            child: EventBox(
              event: _events[index],
              size: size,
              isSelected: _events[index].isSelected,
            ),
            onTap: () {
              if (_isSelectedMode && !_isEditMode) {
                _doEventActions(index);
              }
            },
            onLongPress: () {
              if (!_isEditMode) {
                _doEventActions(index);
              }
            },
          );
        },
      ),
    );
  }

  void _doEventActions(int index) {
    setState(() {
      if (_selectedItemIndexes.isEmpty) {
        _isSelectedMode = true;
        _events[index].isSelected = true;

        _selectedItemIndexes.add(index);
      } else if (!_selectedItemIndexes.contains(index)) {
        _events[index].isSelected = true;

        _selectedItemIndexes.add(index);
      } else if (_selectedItemIndexes.length == 1) {
        _isSelectedMode = false;
        _events[index].isSelected = false;

        _selectedItemIndexes.remove(index);
      } else {
        _events[index].isSelected = false;

        _selectedItemIndexes.remove(index);
      }
    });
  }

  void _setFavoriteFlag(Event event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
  }

  Container _getInputBox(Size size) {
    final local = AppLocalizations.of(context);
    return Container(
      width: size.width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _initKeyboardIcon(Icons.attach_file, () => _openAttachDialog(local)),
          Expanded(
            child: TextField(
              controller: _fieldText,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: local?.enterFieldHint ?? '',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: secondaryMessageTextColor,
                ),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          _initKeyboardIcon(
            !_isEditMode ? Icons.send : Icons.edit,
            !_isEditMode ? _sendEvent : _turnOffEditMode,
          ),
        ],
      ),
    );
  }

  IconButton _initKeyboardIcon(IconData icon, void Function() onPressed) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(icon, size: 24),
      onPressed: onPressed,
    );
  }

  Future<void> _openAttachDialog(AppLocalizations? local) async {
    final info = local?.attachDialogInfo ?? '';
    final cancel = local?.cancel ?? '';
    final gallery = local?.gallery ?? '';
    final camera = local?.camera ?? '';
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(info, style: const TextStyle(fontSize: 24)),
        ),
        actions: <Widget>[
          _initDialogButton(cancel, _closeDialog),
          _initDialogButton(gallery, () => _attachFile(ImageSource.gallery)),
          _initDialogButton(camera, () => _attachFile(ImageSource.camera)),
        ],
      ),
    ));
  }

  TextButton _initDialogButton(String text, void Function() action) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  void _closeDialog() => Navigator.of(context).pop(false);

  void _attachFile(ImageSource imageSource) async {
    final _picker = ImagePicker();
    final photo = await _picker.pickImage(source: imageSource);
    _sendEvent(photo?.path);
    _closeDialog();
  }

  void _sendEvent([String? path]) {
    if (_fieldText.text.isEmpty && path == null) return;

    setState(() {
      widget.chat.events.add(
        Event(_fieldText.text, DateTime.now(), photoPath: path),
      );
      _fieldText.clear();
    });
  }

  Future<bool> _handleBackButton() async {
    if (!_isSelectedMode) {
      return true;
    } else {
      _disableSelect();
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
