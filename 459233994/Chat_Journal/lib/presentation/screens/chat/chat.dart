import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../widgets/app_theme/inherited_app_theme.dart';
import 'chat_bottom_bar.dart';
import 'chat_cubit.dart';
import 'chat_search_cubit..dart';
import 'chat_search_state.dart';
import 'chat_state.dart';
import 'events/event_list.dart';

class ChatScreen extends StatefulWidget {
  final Chat _chat;
  final Function _getChatsDelegate;

  ChatScreen({
    super.key,
    required chat,
    required getChatsDelegate,
  })  : _chat = chat,
        _getChatsDelegate = getChatsDelegate;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final Function _addToMessagesList;
  final GlobalKey _scaffoldKey = GlobalKey();

  _ChatScreenState() {
    _addToMessagesList = _addToEvents;
  }

  void _addToEvents(Event event, BuildContext context) {
    ReadContext(context).read<ChatCubit>().addEventToChat(event);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<ChatSearchCubit>(
          create: (context) => ChatSearchCubit(),
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: InheritedAppTheme.of(context)?.getTheme.keyColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: BlocBuilder<ChatSearchCubit, ChatSearchState>(
              builder: (context, searchState) {
                if (searchState is ChatSearchNotLoaded) {
                  return _textField();
                } else {
                  return Text(
                    widget._chat.name,
                    style: TextStyle(
                        color:
                            InheritedAppTheme.of(context)?.getTheme.keyColor),
                  );
                }
              },
            ),
          ),
          actions: _actionAppbarButtons(),
          backgroundColor: InheritedAppTheme.of(context)?.getTheme.themeColor,
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, chatState) {
            if (chatState is ChatLoaded) {
              return SizedBox.expand(
                child: Container(
                  color:
                      InheritedAppTheme.of(context)?.getTheme.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<ChatSearchCubit, ChatSearchState>(
                        builder: (context, searchState) {
                          if (searchState is ChatNotSearch) {
                            return EventList(
                              events: chatState.chat.events,
                              isFavoritesMode: chatState.isFavorite,
                              getChatsDelegate: widget._getChatsDelegate,
                              updateListDelegate:
                                  ReadContext(_scaffoldKey.currentContext!)
                                      .read<ChatCubit>()
                                      .updateChat,
                            );
                          } else if (searchState is ChatSearchLoaded) {
                            return EventList(
                              events: searchState.events,
                              isFavoritesMode: chatState.isFavorite,
                              getChatsDelegate: widget._getChatsDelegate,
                              updateListDelegate:
                                  ReadContext(_scaffoldKey.currentContext!)
                                      .read<ChatCubit>()
                                      .updateChat,
                            );
                          }
                          return Expanded(
                            child: Container(),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ChatBottomBar(
                          addToChat: _addToMessagesList,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              ReadContext(context).read<ChatCubit>().loadChat(widget._chat);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: InheritedAppTheme.of(context)!.getTheme.backgroundColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: InheritedAppTheme.of(context)!.getTheme.textColor,
            ),
          ),
          hintText: 'Search',
        ),
        onSubmitted: (value) => {
          ReadContext(_scaffoldKey.currentContext!)
              .read<ChatSearchCubit>()
              .searchEvents(
                value,
                ReadContext(_scaffoldKey.currentContext!)
                    .read<ChatCubit>()
                    .getEvents(),
              ),
        },
      ),
    );
  }

  List<Widget> _actionAppbarButtons() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.search,
            color: InheritedAppTheme.of(context)?.getTheme.keyColor,
          ),
          onTap: () => ReadContext(_scaffoldKey.currentContext!)
              .read<ChatSearchCubit>()
              .changeState(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.bookmark_border_outlined,
            color: InheritedAppTheme.of(context)?.getTheme.keyColor,
          ),
          onTap: () {
            ReadContext(_scaffoldKey.currentContext!)
                .read<ChatCubit>()
                .changeFavoriteState();
          },
        ),
      ),
    ];
  }
}
