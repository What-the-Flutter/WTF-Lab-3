import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '/constants/app_constants.dart';
import '/constants/constants.dart';
import '/providers/providers.dart';
import '/utils/utils.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'add_chat_page.dart';
import 'chat_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState({Key? key});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ScrollController _listScrollController = ScrollController();

  int _limit = 20;
  final int _limitIncrement = 20;
  final bool _isLoading = false;

  late final AuthProvider _authProvider;
  late final String _currentUserId;
  late final HomeProvider _homeProvider;
  late final ChatProvider _chatProvider;
  late final ThemeProvider _themeProvider;
  final Debouncer _searchDebouncer = Debouncer(milliseconds: 300);
  final StreamController<bool> _btnClearController = StreamController<bool>();
  final TextEditingController _searchBarTec = TextEditingController();

  final List<PopupChoices> _choices = <PopupChoices>[
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
    PopupChoices(title: 'Change theme', icon: Icons.invert_colors)
  ];

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _homeProvider = context.read<HomeProvider>();
    _chatProvider = context.read<ChatProvider>();
    _themeProvider = context.read<ThemeProvider>();

    if (_authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      _currentUserId = _authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
    _registerNotification();
    _configLocalNotification();
    _listScrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppConstants.homeTitle,
            style: TextStyle(color: ColorConstants.primaryColor),
          ),
          centerTitle: true,
          actions: <Widget>[_popupMenu()],
        ),
        bottomNavigationBar: BottomNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: _addListItem,
          tooltip: 'Add new chat',
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: WillPopScope(
            child: Stack(
              children: <Widget>[
                // List
                Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _homeProvider.getStreamFireStore(
                            FirestoreConstants.pathChatsCollection,
                            _limit,
                            _currentUserId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if ((snapshot.data?.docs.length ?? 0) > 0) {
                              final chats = <Chat>[];
                              for (var doc in snapshot.data!.docs) {
                                final _chat = Chat.fromDocument(doc);
                                chats.add(_chat);
                              }
                              chats.sort(_chatProvider.compare);

                              return ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemBuilder: (context, index) =>
                                    _item(context, chats[index]),
                                itemCount: snapshot.data?.docs.length,
                                controller: _listScrollController,
                              );
                            } else {
                              return const Center(
                                child: Text('No chats'),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.themeColor,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),

                // Loading
                Positioned(
                  child: _isLoading ? LoadingView() : const SizedBox.shrink(),
                )
              ],
            ),
            onWillPop: _onBackPress,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _btnClearController.close();
    _authProvider.dispose();
  }

  void _registerNotification() {
    _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage: $message');
      if (message.notification != null) {
        _showNotification(message.notification!);
      }
      return;
    });

    _firebaseMessaging.getToken().then((token) {
      print('push token: $token');
      if (token != null) {
        _homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection,
            _currentUserId, {'pushToken': token});
      }
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void _configLocalNotification() {
    final _initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    final _initializationSettingsIOS = const IOSInitializationSettings();
    final _initializationSettings = InitializationSettings(
        android: _initializationSettingsAndroid,
        iOS: _initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
  }

  void _scrollListener() {
    if (_listScrollController.offset >=
            _listScrollController.position.maxScrollExtent &&
        !_listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void _onItemMenuPress(PopupChoices choice) async {
    if (choice.title == 'Log out') {
      _handleSignOut();
    }
    if (choice.title == 'Change theme') {
      _changeTheme();
    }
  }

  void _showNotification(RemoteNotification remoteNotification) async {
    final _iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    final _platformChannelSpecifics = NotificationDetails(
        android: const AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description',
            importance: Importance.max),
        iOS: _iOSPlatformChannelSpecifics);

    print(remoteNotification);

    await _flutterLocalNotificationsPlugin.show(
      0,
      remoteNotification.title,
      remoteNotification.body,
      _platformChannelSpecifics,
      payload: null,
    );
  }

  void _addListItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddChat(
                isEdited: false,
                currentChatId: '',
                chatName: '',
              )),
    );
  }

  void _editListItem(String currentChatId, String chatName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddChat(
                isEdited: true,
                currentChatId: currentChatId,
                chatName: chatName,
              )),
    );
  }

  Future<bool> _onBackPress() {
    _openDialog();
    return Future.value(false);
  }

  Future<void> _openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: ColorConstants.themeColor,
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    const Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: const Icon(
                        Icons.cancel,
                        color: ColorConstants.primaryColor,
                      ),
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    const Text(
                      'Cancel',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: const Icon(
                        Icons.check_circle,
                        color: ColorConstants.primaryColor,
                      ),
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    const Text(
                      'Yes',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  Future<void> _handleSignOut() async {
    _authProvider.handleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  Widget _popupMenu() {
    return PopupMenuButton<PopupChoices>(
      onSelected: _onItemMenuPress,
      itemBuilder: (context) {
        return _choices.map((choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: const TextStyle(color: ColorConstants.primaryColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }

  Widget _item(BuildContext context, Chat chat) {
    final _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    if (_isIos) {
      return _ios(chat, context);
    } else {
      return _android(chat, context);
    }
  }

  GestureDetector _android(Chat _userChat, BuildContext context) {
    return GestureDetector(
        onLongPress: () => {_askedToLead(_userChat)},
        child: Container(
          child: TextButton(
            child: Row(
              children: <Widget>[
                const Material(
                  child: Icon(
                    Icons.circle,
                    size: 50,
                    color: ColorConstants.greyColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  clipBehavior: Clip.hardEdge,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(_userChat.name,
                              maxLines: 3,
                              style: const TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: AppConstants.fontSize),
                              softWrap: true),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 20),
                  ),
                ),
                _userChat.isPinned
                    ? const Icon(
                        Icons.star,
                        size: 36,
                      )
                    : const Icon(Icons.star_border, size: 36),
              ],
            ),
            onPressed: () {
              if (Utilities.isKeyboardShowing()) {
                Utilities.closeKeyboard(context);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    arguments: ChatPageArguments(
                      userId: _userChat.userId,
                      chatId: _userChat.chatId,
                      chatName: _userChat.name,
                    ),
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        ));
  }

  Dismissible _ios(Chat _chat, BuildContext context) {
    return Dismissible(
        key: Key(_chat.chatId),
        child: Container(
          child: TextButton(
            child: Row(
              children: <Widget>[
                const Material(
                  child: Icon(
                    Icons.circle,
                    size: 50,
                    color: ColorConstants.greyColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  clipBehavior: Clip.hardEdge,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(_chat.name,
                              maxLines: 3,
                              style: const TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: AppConstants.fontSize),
                              softWrap: true),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 20),
                  ),
                ),
              ],
            ),
            onPressed: () {
              if (Utilities.isKeyboardShowing()) {
                Utilities.closeKeyboard(context);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    arguments: ChatPageArguments(
                      userId: _chat.userId,
                      chatId: _chat.chatId,
                      chatName: _chat.name,
                    ),
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        ));
  }

  void _askedToLead(Chat chat) async {
    switch (await showDialog<_ChatChoice>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _ChatChoice.info);
                },
                child: const Text('Info'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _ChatChoice.edit);
                },
                child: const Text('Edit'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _ChatChoice.delete);
                },
                child: const Text('Delete'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, _ChatChoice.pin);
                },
                child: chat.isPinned ? const Text('Unpin') : const Text('Pin'),
              ),
            ],
          );
        })) {
      case _ChatChoice.delete:
        _chatProvider.deleteChat(_currentUserId, chat.chatId);
        break;
      case _ChatChoice.pin:
        _chatProvider.pinChat(_currentUserId, chat.chatId);
        break;
      case _ChatChoice.edit:
        _editListItem(chat.chatId, chat.name);
        break;
      case _ChatChoice.info:
        try {
          _chatProvider.getInfo(context, _currentUserId, chat.chatId);
        } catch (e) {
          print(e);
        }
        break;
      case null:
        break;
    }
  }

  void _changeTheme() {
    _themeProvider.switchTheme();
  }
}

enum _ChatChoice { delete, edit, pin, info }
