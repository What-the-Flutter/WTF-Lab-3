import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/chat.dart';
import '../../../../domain/entities/event.dart';
import '../../../widgets/app_theme/inherited_app_theme.dart';
import 'event_dialog_cubit.dart';
import 'event_dialog_state.dart';

class EventDialog extends StatefulWidget {
  final Event _event;
  final Function _updateEvent;
  final Function _deleteEvent;
  final Function _updateChat;
  final Function _getChats;

  EventDialog({
    required event,
    required updateEvent,
    required deleteEvent,
    required updateChat,
    required getChats,
  })  : _event = event,
        _updateEvent = updateEvent,
        _deleteEvent = deleteEvent,
        _updateChat = updateChat,
        _getChats = getChats;

  @override
  State<EventDialog> createState() => _EventDialogState(
        event: _event,
        deleteEvent: _deleteEvent,
        updateEvent: _updateEvent,
        getChats: _getChats,
      );
}

class _EventDialogState extends State<EventDialog> {
  final Event _event;
  final Function _updateEvent;
  final Function _deleteEvent;
  final Function _getChats;
  final GlobalKey _globalKey = GlobalKey();

  _EventDialogState({
    required event,
    required updateEvent,
    required deleteEvent,
    required getChats,
  })  : _event = event,
        _updateEvent = updateEvent,
        _deleteEvent = deleteEvent,
        _getChats = getChats;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: BlocProvider<EventDialogCubit>(
          create: (context) => EventDialogCubit(),
          child: Container(
            key: _globalKey,
            // height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      InkWell(
                        child: const ListTile(
                          leading: Icon(Icons.edit),
                          title: Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xff545F66),
                            ),
                          ),
                        ),
                        onTap: () {
                          ReadContext(_globalKey.currentContext!)
                              .read<EventDialogCubit>()
                              .setEdit();
                        },
                      ),
                      _editTextField(),
                      InkWell(
                        child: const ListTile(
                          leading: Icon(Icons.delete),
                          title: Text(
                            'Delete',
                            style: TextStyle(
                              color: Color(0xff545F66),
                            ),
                          ),
                        ),
                        onTap: () {
                          _deleteEvent(_event);
                          widget._updateChat();
                          Navigator.of(context, rootNavigator: true).pop(true);
                        },
                      ),
                      InkWell(
                        child: const ListTile(
                          leading: Icon(Icons.content_copy),
                          title: Text(
                            'Copy',
                            style: TextStyle(
                              color: Color(0xff545F66),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (_event.textData != null) {
                            await Clipboard.setData(
                                ClipboardData(text: _event.textData));
                          }
                          Navigator.of(context, rootNavigator: true).pop(true);
                        },
                      ),
                      InkWell(
                        child: const ListTile(
                          leading: Icon(Icons.drive_file_move),
                          title: Text(
                            'Move',
                            style: TextStyle(
                              color: Color(0xff545F66),
                            ),
                          ),
                        ),
                        onTap: () {
                          ReadContext(_globalKey.currentContext!)
                              .read<EventDialogCubit>()
                              .setMove();
                        },
                      ),
                    ],
                  ),
                  _chatListToMove(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _editTextField() {
    return BlocBuilder<EventDialogCubit, EventDialogState>(
      builder: (context, state) {
        if (state is EventDialogEdit) {
          return TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: Color(0xff829399),
                ),
              ),
              hintText: 'Edit event',
            ),
            onSubmitted: (text) {
              _updateEvent(_event, _event.copyWith(textMessage: text));
              widget._updateChat();
              Navigator.of(context, rootNavigator: true).pop(true);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _chatListToMove() {
    return BlocBuilder<EventDialogCubit, EventDialogState>(
      builder: (context, state) {
        if (state is EventDialogMove) {
          List<Chat> chats = _getChats();
          return Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    chats[index].pageIcon,
                    color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                  ),
                  title: Text(
                    chats[index].name,
                    style: TextStyle(
                      color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                    ),
                  ),
                  onTap: () {
                    chats[index].events.add(_event);
                    _deleteEvent(_event);
                    widget._updateChat();
                    Navigator.of(context, rootNavigator: true).pop(true);
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
