import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '/constants/constants.dart';
import '/models/models.dart';
import '/providers/providers.dart';
import '../widgets/widgets.dart';
import 'full_photo_page.dart';
import 'login_page.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.arguments}) : super(key: key);

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<QueryDocumentSnapshot> _messages = [];
  int _limit = 20;
  final int _limitIncrement = 20;

  File? _imageFile;
  bool _isLoading = false;
  bool _isEditing = false;
  String _imageUrl = '';
  String _chatId = '';
  String _currentMessageId = '';
  late String _currentUserId;

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  late final ChatProvider _chatProvider;
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _chatProvider = context.read<ChatProvider>();
    _authProvider = context.read<AuthProvider>();

    _listScrollController.addListener(_scrollListener);
    _readLocal();
  }

  void _scrollListener() {
    if (!_listScrollController.hasClients) return;
    if (_listScrollController.offset >=
            _listScrollController.position.maxScrollExtent &&
        !_listScrollController.position.outOfRange &&
        _limit <= _messages.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void _readLocal() {
    if (_authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      _currentUserId = _authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
    _chatId = widget.arguments.chatId;

    _chatProvider.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      _currentUserId,
      {FirestoreConstants.chatId: _chatId},
    );
  }

  Future _getImage() async {
    final imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      if (_imageFile != null) {
        setState(() {
          _isLoading = true;
        });
        _uploadFile();
      }
    }
  }

  Future _uploadFile() async {
    final _fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final _uploadTask = await _chatProvider.uploadFile(_imageFile!, _fileName);
    try {
      _imageUrl = await (await _uploadTask).ref.getDownloadURL();
      setState(() {
        _isLoading = false;
        _onSendMessage(_imageUrl, TypeMessage.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void _onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      _textEditingController.clear();
      _chatProvider.sendMessage(content, type, _chatId, _currentUserId);
      if (_listScrollController.hasClients) {
        _listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  Widget _item(int _index, Message message) {
    if (message.chatId == _chatId) {
      return Row(
        children: <Widget>[
          message.isPinned == true
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
          message.type == TypeMessage.text
              // Text
              ? Container(
                  child: Text(
                    message.content,
                    style: const TextStyle(color: ColorConstants.primaryColor),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: ColorConstants.greyColor2,
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(bottom: 20, right: 10),
                )
              : message.type == TypeMessage.image
                  // Image
                  ? Container(
                      child: OutlinedButton(
                        child: Material(
                          child: Image.network(
                            message.content,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                decoration: const BoxDecoration(
                                  color: ColorConstants.greyColor2,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                width: 200,
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConstants.themeColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return Material(
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                              );
                            },
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullPhotoPage(
                                url: message.content,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0))),
                      ),
                      margin: const EdgeInsets.only(bottom: 20, right: 10),
                    )
                  // Sticker
                  : Container(
                      child: Image.asset(
                        'images/${message.content}.gif',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      margin: const EdgeInsets.only(bottom: 20, right: 10),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    }
    return const SizedBox.shrink();
  }

  Future<bool> _onBackPress() {
    _chatProvider.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      _currentUserId,
      {FirestoreConstants.chatId: null},
    );
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.arguments.chatName,
          style: const TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  _listMessage(),
                  // Input content
                  _input(),
                ],
              ),
              _loading()
            ],
          ),
          onWillPop: _onBackPress,
        ),
      ),
    );
  }

  Widget _loading() {
    return Positioned(
      child: _isLoading ? LoadingView() : const SizedBox.shrink(),
    );
  }

  Widget _input() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: _getImage,
                color: ColorConstants.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                if (!_isEditing) {
                  _onSendMessage(_textEditingController.text, TypeMessage.text);
                } else {
                  _chatProvider.updateMessage(
                      _currentUserId, _chatId, _currentMessageId, value);
                  _isEditing = false;
                  _textEditingController.text = '';
                }
              },
              style: const TextStyle(
                  color: ColorConstants.primaryColor, fontSize: 15),
              controller: _textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: ColorConstants.greyColor),
              ),
              focusNode: _focusNode,
              autofocus: true,
            ),
          ),
          // Button send message
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (!_isEditing) {
                    _onSendMessage(
                        _textEditingController.text, TypeMessage.text);
                  } else {
                    _chatProvider.updateMessage(_currentUserId, _chatId,
                        _currentMessageId, _textEditingController.text);
                    _isEditing = false;
                    _textEditingController.text = '';
                  }
                },
                color: ColorConstants.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: ColorConstants.greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget _listMessage() {
    return Flexible(
      child: _currentUserId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  _chatProvider.getChatStream(_currentUserId, _chatId, _limit),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    final _messages = <Message>[];
                    final docs = snapshot.data!.docs;
                    for (var doc in docs) {
                      _messages.add(Message.fromDocument(doc));
                    }
                    _messages.sort(_chatProvider.compare);

                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, _index) {
                        final _isIos =
                            Theme.of(context).platform == TargetPlatform.iOS;
                        return _isIos
                            ? _ios(_messages, _index)
                            : _android(docs, _messages, _index);
                      },
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: _listScrollController,
                    );
                  } else {
                    return const Center(child: Text('No message here yet...'));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.themeColor,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.themeColor,
              ),
            ),
    );
  }

  GestureDetector _android(List<QueryDocumentSnapshot<Object?>> docs,
      List<Message> messages, int _index) {
    return GestureDetector(
        onLongPress: () => {
              _askedToLead(
                  docs[_index].id,
                  messages[_index].content,
                  messages[_index].type,
                  messages[_index].isPinned)
            },
        child: _item(_index, messages[_index]));
  }

  Dismissible _ios(List<Message> messages, int _index) {
    return Dismissible(
        onDismissed: (direction) {
          /**
           * TODO: добавить логику
           */
        },
        key: Key(messages[_index].chatId),
        child: _item(_index, messages[_index]));
  }

  Future<void> _askedToLead(
    final String _id,
    final String _text,
    final int _type,
    final bool _isPinned,
  ) async {
    switch (await showDialog<_MessageChoice>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _MessageChoice.update);
                },
                child: const Text('Update'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _MessageChoice.delete);
                },
                child: const Text('Delete'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _MessageChoice.copy);
                },
                child: const Text('Copy'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _MessageChoice.pin);
                },
                child: _isPinned ? const Text('Unpin') : const Text('Pin'),
              ),
            ],
          );
        })) {
      case _MessageChoice.update:
        _textEditingController.text = _text;
        _currentMessageId = _id;
        _isEditing = true;
        break;
      case _MessageChoice.delete:
        _chatProvider.deleteMessage(_currentUserId, _chatId, _id);
        break;
      case _MessageChoice.copy:
        if (_type == 0) {
          await Clipboard.setData(ClipboardData(text: _text));
        } else if (_type == 1) {
          /**
           * TODO: добавить реализацию копирования картинок
           */
        }
        break;
      case _MessageChoice.pin:
        _chatProvider.pinMessage(_currentUserId, _chatId, _id, _isPinned);
        break;
      case null:
        // dialog dismissed
        break;
    }
  }
}

enum _MessageChoice { delete, update, copy, pin }

class ChatPageArguments {
  final String userId;
  final String chatId;
  final String chatName;

  ChatPageArguments(
      {required this.userId, required this.chatId, required this.chatName});
}
