import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';
import '../../screens/chat/chat_cubit.dart';
import '../../screens/home/home_cubit.dart';
import '../app_theme/inherited_app_theme.dart';
import 'event_dialog_cubit.dart';
import 'event_dialog_state.dart';

class EventDialog extends StatefulWidget {
  final Event _event;

  EventDialog({
    required event,
  })  : _event = event;

  @override
  State<EventDialog> createState() => _EventDialogState(
        event: _event,
      );
}

class _EventDialogState extends State<EventDialog> {
  final Event _event;

  _EventDialogState({
    required event,
  })  : _event = event;

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
                      ReadContext(context)
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
                      ReadContext(context).read<ChatCubit>().deleteEvent(event: _event);
                      ReadContext(context).read<ChatCubit>().updateChat();
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
                      ReadContext(context)
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
    );
  }

  Widget _editTextField() {
    return BlocBuilder<EventDialogCubit, EventDialogState>(
      builder: (context, state) {
        if (state.isEdit) {
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
              ReadContext(context).read<ChatCubit>().editEvent(editedEvent: _event.copyWith(textMessage: text));
              ReadContext(context).read<ChatCubit>().updateChat();
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
        if (state.isMove) {
          var chats = ReadContext(context).read<HomeCubit>().getChats();
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
                    ReadContext(context).read<ChatCubit>().deleteEvent(event: _event);
                    ReadContext(context).read<ChatCubit>().updateChat();
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
