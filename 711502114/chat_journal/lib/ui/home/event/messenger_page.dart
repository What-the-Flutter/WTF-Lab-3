import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/colors.dart';
import '../chat.dart';
import 'event.dart';
import 'info_box.dart';
import 'message_data.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final _fieldText = TextEditingController();

  bool _isFavoriteMode = false;

  final Icon _bookmarkIcon = const Icon(Icons.bookmark_border_outlined);
  final Icon _bookmarkIconWitchColor = const Icon(
    Icons.bookmark,
    color: Colors.yellow,
  );

  late List<MessageData> _events;

  @override
  void initState() {
    super.initState();
    _events = widget.chat.messages;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.title),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 24,
              ),
              onPressed: _lookForWords,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: IconButton(
              icon: _isFavoriteMode ? _bookmarkIconWitchColor : _bookmarkIcon,
              onPressed: _showFavorites,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.chat.messages.isNotEmpty
                ? _buildMessageList(size)
                : InfoBox(size: size, mainTitle: widget.chat.title),
            _getInputBox(size),
          ],
        ),
      ),
    );
  }

  void _lookForWords() {}

  void _showFavorites() {
    setState(() {
      _isFavoriteMode = !_isFavoriteMode;
      if (_isFavoriteMode) {
        _events = widget.chat.messages
            .where((element) => element.isFavorite)
            .toList();
      } else {
        _events = widget.chat.messages;
      }
    });
  }

  Expanded _buildMessageList(Size size) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final length = _events.length;
          return InkWell(
            child: Event(
              messageData: _events[length - 1 - index],
              size: size,
            ),
            onTap: _doEventActions,
            onLongPress: () => _setFavoriteFlag(_events[length - 1 - index]),
          );
        },
      ),
    );
  }

  void _doEventActions() {}

  void _setFavoriteFlag(MessageData messageData) {
    setState(() {
      messageData.isFavorite = !messageData.isFavorite;
    });
  }

  Container _getInputBox(Size size) {
    return Container(
      width: size.width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.attach_file,
              size: 24,
            ),
            onPressed: _attachFile,
          ),
          Expanded(
            child: TextField(
              controller: _fieldText,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter event',
                hintStyle: TextStyle(fontSize: 20),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.send,
              size: 24,
            ),
            onPressed: _sendEvent,
          ),
        ],
      ),
    );
  }

  Future<void> _attachFile() async {
    final _picker = ImagePicker();
    late XFile? photo;

    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            'How would you like to upload an image?',
            style: TextStyle(fontSize: 24),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: _closeDialog,
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              photo = await _picker.pickImage(source: ImageSource.gallery);
              _sendEvent(photo?.path);
              _closeDialog();
            },
            child: const Text(
              'Gallery',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              photo = await _picker.pickImage(source: ImageSource.camera);
              _sendEvent(photo?.path);
              _closeDialog();
            },
            child: const Text(
              'Camera',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _closeDialog() => Navigator.of(context).pop(false);

  void _sendEvent([String? path]) {
    if (_fieldText.text.isEmpty && path == null) return;

    setState(() {
      widget.chat.messages.add(
        MessageData(_fieldText.text, DateTime.now(), photoPath: path),
      );
      _fieldText.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
