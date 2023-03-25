import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../widgets/app_theme/app_theme_cubit.dart';
import '../../widgets/chat/chat_bottom_bar.dart';
import '../../widgets/events/event_list.dart';
import 'chat_cubit.dart';
import 'chat_search_cubit..dart';
import 'chat_search_state.dart';
import 'chat_state.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  ChatScreen({
    super.key,
    required this.chat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    ReadContext(context).read<ChatCubit>().loadChat(widget.chat);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, chatState) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .keyColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Builder(
              builder: (context) {
                if (chatState.isSearched == true) {
                  return _textField();
                } else {
                  return Text(
                    widget.chat.name,
                    style: TextStyle(
                        color: ReadContext(context)
                            .read<AppThemeCubit>()
                            .state
                            .customTheme
                            .keyColor),
                  );
                }
              },
            ),
          ),
          actions: _actionAppbarButtons(),
          backgroundColor: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .themeColor,
        ),
        body: Builder(
          builder: (context) {
            if (chatState.isLoaded) {
              return SizedBox.expand(
                child: Container(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .backgroundColor,
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<ChatSearchCubit, ChatSearchState>(
                        builder: (context, searchState) {
                          if (searchState.isSearched == false) {
                            return EventList(
                              events: ReadContext(context)
                                  .read<ChatCubit>()
                                  .getEvents(),
                              isFavoritesMode: chatState.isFavorite,
                            );
                          } else if (searchState == true) {
                            return EventList(
                              events: searchState.events,
                              isFavoritesMode: chatState.isFavorite,
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
                          chatId: widget.chat.id!,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      );
    });
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .backgroundColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .textColor,
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
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .keyColor,
          ),
          onTap: () => ReadContext(_scaffoldKey.currentContext!)
              .read<ChatCubit>()
              .changeSearchedState(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.bookmark_border_outlined,
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .keyColor,
          ),
          onTap: () => ReadContext(_scaffoldKey.currentContext!)
              .read<ChatCubit>()
              .changeFavoriteState(),
        ),
      ),
    ];
  }
}
