import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/entities/chat.dart';
import '../../widgets/app_theme/inherited_theme.dart';
import '../../widgets/chat/chat_bottom_bar.dart';
import '../../widgets/events/event_list.dart';
import '../settings/settings_cubit.dart';
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
  @override
  void initState() {
    super.initState();
    ReadContext(context).read<ChatCubit>().loadChat(widget.chat);
    ReadContext(context).read<ChatCubit>().initChatListener(widget.chat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, chatState) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: InheritedAppTheme.of(context)!.themeData.keyColor,
              ),
              onTap: () {
                Navigator.pop(context);
                ReadContext(context).read<ChatCubit>().disposeChatListener();
                ReadContext(context).read<ChatCubit>().closeChat();
              },
            ),
            title: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  );
                },
                child: chatState.isSearched == true
                    ? _textField()
                    : Center(
                        child: Text(
                          widget.chat.name,
                          style: TextStyle(
                            color: InheritedAppTheme.of(context)!
                                .themeData
                                .keyColor,
                          ),
                        ),
                      ),
              ),
            ),
            actions: _actionAppbarButtons(),
            backgroundColor:
                InheritedAppTheme.of(context)!.themeData.themeColor,
          ),
          body: Builder(
            builder: (context) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 225),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: chatState.isLoaded
                    ? SizedBox.expand(
                        child: Container(
                          decoration: _background(),
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
                                  } else if (searchState.isSearched == true) {
                                    return searchState.events!.isNotEmpty
                                        ? EventList(
                                            events: searchState.events,
                                            isFavoritesMode:
                                                chatState.isFavorite,
                                          )
                                        : _noSearchedEvents();
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: InheritedAppTheme.of(context)!.themeData.backgroundColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: InheritedAppTheme.of(context)!.themeData.textColor,
            ),
          ),
          hintText: 'Search',
        ),
        onSubmitted: (value) => {
          ReadContext(context).read<ChatSearchCubit>().searchEvents(
                value,
                ReadContext(context).read<ChatCubit>().getEvents(),
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
            color: InheritedAppTheme.of(context)!.themeData.keyColor,
          ),
          onTap: () {
            ReadContext(context).read<ChatCubit>().changeSearchedState();
            if (ReadContext(context).read<ChatSearchCubit>().state.isSearched ==
                true) {
              ReadContext(context).read<ChatSearchCubit>().closeSearch();
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.bookmark_border_outlined,
            color: InheritedAppTheme.of(context)!.themeData.keyColor,
          ),
          onTap: () =>
              ReadContext(context).read<ChatCubit>().changeFavoriteState(),
        ),
      ),
    ];
  }

  BoxDecoration _background() {
    final imageDecoration = BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: FileImage(
          File(
            ReadContext(context).read<SettingsCubit>().state.backgroundImage!,
          ),
        ),
      ),
    );
    final themeDecoration = BoxDecoration(
      color: InheritedAppTheme.of(context)!.themeData.backgroundColor,
    );
    final background =
        ReadContext(context).read<SettingsCubit>().state.backgroundImage != null
            ? imageDecoration
            : themeDecoration;
    return background;
  }

  Widget _noSearchedEvents() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/empty_box.json',
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No such events'),
          ),
        ],
      ),
    );
  }
}
