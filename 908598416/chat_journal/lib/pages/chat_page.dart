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
  late String currentUserId;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  final int _limitIncrement = 20;

  File? imageFile;
  bool isLoading = false;
  bool isEditing = false;
  String imageUrl = '';
  String chatId = '';
  String currentMessageId = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late final ChatProvider chatProvider;
  late final AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();

    listScrollController.addListener(_scrollListener);
    _readLocal();
  }

  void _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void _readLocal() {
    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
    chatId = widget.arguments.chatId;

    chatProvider.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chatId: chatId},
    );
  }

  Future _getImage() async {
    final imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        _uploadFile();
      }
    }
  }

  Future _uploadFile() async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var uploadTask = await chatProvider.uploadFile(imageFile!, fileName);
    try {
      imageUrl = await (await uploadTask).ref.getDownloadURL();
      setState(() {
        isLoading = false;
        _onSendMessage(imageUrl, TypeMessage.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void _onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(content, type, chatId, currentUserId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  Widget _item(int index, DocumentSnapshot? document) {
    if (document != null) {
      var messageChat = Message.fromDocument(document);
      if (messageChat.chatId == chatId) {
        return Row(
          children: <Widget>[
            messageChat.isFavorite == true
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            messageChat.type == TypeMessage.text
                // Text
                ? Container(
                    child: Text(
                      messageChat.content,
                      style:
                          const TextStyle(color: ColorConstants.primaryColor),
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.greyColor2,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(bottom: 20, right: 10),
                  )
                : messageChat.type == TypeMessage.image
                    // Image
                    ? Container(
                        child: OutlinedButton(
                          child: Material(
                            child: Image.network(
                              messageChat.content,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                                  url: messageChat.content,
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
                          'images/${messageChat.content}.gif',
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
    }
    return const SizedBox.shrink();
  }

  Future<bool> _onBackPress() {
    chatProvider.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
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
      child: isLoading ? LoadingView() : const SizedBox.shrink(),
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
                if (!isEditing) {
                  _onSendMessage(textEditingController.text, TypeMessage.text);
                } else {
                  chatProvider.updateMessage(
                      currentUserId, chatId, currentMessageId, value);
                  isEditing = false;
                  textEditingController.text = '';
                }
              },
              style: const TextStyle(
                  color: ColorConstants.primaryColor, fontSize: 15),
              controller: textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: ColorConstants.greyColor),
              ),
              focusNode: focusNode,
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
                  if (!isEditing) {
                    _onSendMessage(
                        textEditingController.text, TypeMessage.text);
                  } else {
                    chatProvider.updateMessage(currentUserId, chatId,
                        currentMessageId, textEditingController.text);
                    isEditing = false;
                    textEditingController.text = '';
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
      child: currentUserId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getChatStream(currentUserId, chatId, _limit),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        var isIos =
                            Theme.of(context).platform == TargetPlatform.iOS;
                        if (isIos) {
                          return Dismissible(
                              onDismissed: (direction) {
                                /**
                           * TODO: добавить логику
                           */
                              },
                              key: Key(snapshot.data!.docs[index].id),
                              child: _item(index, snapshot.data?.docs[index]));
                        }
                        return GestureDetector(
                            onLongPress: () => {
                                  _askedToLead(
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index].get('content'),
                                      snapshot.data!.docs[index].get('type'),
                                      snapshot.data!.docs[index]
                                          .get('isFavorite'))
                                },
                            child: _item(index, snapshot.data?.docs[index]));
                      },
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
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

  Future<void> _askedToLead(
      String id, String text, int type, bool isFavorite) async {
    switch (await showDialog<MessageChoice>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, MessageChoice.update);
                },
                child: const Text('Update'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, MessageChoice.delete);
                },
                child: const Text('Delete'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, MessageChoice.copy);
                },
                child: const Text('Copy'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, MessageChoice.pin);
                },
                child: const Text('Pin'),
              ),
            ],
          );
        })) {
      case MessageChoice.update:
        textEditingController.text = text;
        currentMessageId = id;
        isEditing = true;
        break;
      case MessageChoice.delete:
        chatProvider.deleteMessage(currentUserId, chatId, id);
        break;
      case MessageChoice.copy:
        if (type == 0) {
          await Clipboard.setData(ClipboardData(text: text));
        } else if (type == 1) {
          /**
           * TODO: добавить реализацию копирования картинок
           */
        }
        break;
      case MessageChoice.pin:
        chatProvider.pinMessage(currentUserId, chatId, id, isFavorite);
        break;
      case null:
        // dialog dismissed
        break;
    }
  }
}

enum MessageChoice { delete, update, copy, pin }

class ChatPageArguments {
  final String userId;
  final String chatId;
  final String chatName;

  ChatPageArguments(
      {required this.userId, required this.chatId, required this.chatName});
}
