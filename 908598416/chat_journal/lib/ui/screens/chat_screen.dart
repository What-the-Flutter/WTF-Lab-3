import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '/../data/constants/constants.dart';
import '/../data/models/models.dart';
import '../../bloc/cubit/messages/messages_cubit.dart';
import '../../bloc/cubit/sign_in/sign_in_cubit.dart';
import '../../data/providers/providers.dart';
import '../utils/debouncer.dart';
import '../widgets/message_widget.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.arguments}) : super(key: key);

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<QueryDocumentSnapshot> _messages = [];
  int _limit = 20;
  final int _limitIncrement = 20;

  String _textSearch = '';
  File? _imageFile;
  bool _isLoading = false;
  bool _isEditing = false;
  String _imageUrl = '';
  late final String _chatId;
  String _currentMessageId = '';
  late String _currentUserId;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();

  final Debouncer _searchDebouncer = Debouncer(milliseconds: 300);
  final StreamController<bool> _btnClearController = StreamController<bool>();

  late final MessagesCubit _messagesCubit;
  late final SignInCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _messagesCubit = BlocProvider.of<MessagesCubit>(context);
    _authCubit = BlocProvider.of<SignInCubit>(context);

    _chatId = widget.arguments.chatId;

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
    if (_authCubit
        .getUserFirebaseId()
        ?.isNotEmpty == true) {
      _currentUserId = _authCubit.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );
    }
    _messagesCubit.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      _currentUserId,
      {FirestoreConstants.chatId: widget.arguments.chatId},
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
    final _fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final _uploadTask = await _messagesCubit.uploadFile(_imageFile!, _fileName);
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
    if (content
        .trim()
        .isNotEmpty) {
      _textEditingController.clear();
      _messagesCubit.sendMessage(content, type, _chatId, _currentUserId);
      if (_listScrollController.hasClients) {
        _listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  Future<bool> _onBackPress() {
    _messagesCubit.updateDataFirestore(
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
        actions: [IconButton(icon: const Icon(Icons.search),
          onPressed: _search,)
        ],
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
                  _listMessage(),
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
                  _messagesCubit.updateMessage(
                      _currentUserId, _chatId, _currentMessageId, value);
                  _isEditing = false;
                  _textEditingController.text = '';
                }
              },
              style: const TextStyle(
                  color: ColorConstants.primaryColor, fontSize: 20),
              controller: _textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: ColorConstants.greyColor),
              ),
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
                    _messagesCubit.updateMessage(_currentUserId, _chatId,
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
        stream: _messagesCubit.getMessageStream(
            _currentUserId, _chatId, _limit, _textSearch),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              final _messages = <Message>[];
              final docs = snapshot.data!.docs;
              for (var doc in docs) {
                _messages.add(Message.fromDocument(doc));
              }
              _messages.sort(_messagesCubit.compare);

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, _index) {
                  final _isIos =
                      Theme
                          .of(context)
                          .platform == TargetPlatform.iOS;
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
        onLongPress: () =>
        {
          _askedToLead(docs[_index].id, messages[_index].content,
              messages[_index].type, messages[_index].isPinned)
        },
        child: MessageWidget(context, _index, messages[_index]));
  }

  Dismissible _ios(List<Message> messages, int _index) {
    return Dismissible(
        onDismissed: (direction) {
          /**
           * TODO: добавить логику
           */
        },
        key: Key(messages[_index].chatId),
        child: MessageWidget(context, _index, messages[_index]));
  }

  Future<void> _askedToLead(final String _id,
      final String _text,
      final int _type,
      final bool _isPinned,) async {
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
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _MessageChoice.migrate);
                },
                child: const Text('Migrate'),
              )
            ],
          );
        })) {
      case _MessageChoice.update:
        _textEditingController.text = _text;
        _currentMessageId = _id;
        _isEditing = true;
        break;
      case _MessageChoice.delete:
        _messagesCubit.deleteMessage(_currentUserId, _chatId, _id);
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
        _messagesCubit.pinMessage(_currentUserId, _chatId, _id, _isPinned);
        break;
      case _MessageChoice.migrate:
        _migrate();
        break;
      case null:
      // dialog dismissed
        break;

    }
  }

  void _search() {
    setState(() {
      _textSearch = _textEditingController.text;
    });
  }

  void _migrate() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => HomePage(),
      ),
    );
  }

}

enum _MessageChoice { delete, update, copy, pin, migrate}

class ChatPageArguments {
  final String userId;
  final String chatId;
  final String chatName;

  ChatPageArguments(
      {required this.userId, required this.chatId, required this.chatName});
}
