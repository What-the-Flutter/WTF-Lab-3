import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';
import 'event_dialog.dart';
import 'event_list_cubit.dart';
import 'event_widget.dart';

class EventList extends StatelessWidget {
  final List<Event> _events;
  final bool _isFavoritesMode;
  final GlobalKey _globalKey = GlobalKey();
  final Function _updateListDelegate;
  final Function _getChatsDelegate;

  EventList({
    required events,
    required isFavoritesMode,
    required updateListDelegate,
    required getChatsDelegate,
  })  : _events = events,
        _isFavoritesMode = isFavoritesMode,
        _updateListDelegate = updateListDelegate,
        _getChatsDelegate = getChatsDelegate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventListCubit>(
      create: (context) => EventListCubit(_events),
      child: BlocBuilder<EventListCubit, List<Event>>(
        builder: (context, state) {
          return Expanded(
            key: _globalKey,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onLongPress: () => _longPressHandler(context, state[index]),
                    child: (() {
                      if (_isFavoritesMode) {
                        if (state[index].isFavorite) {
                          return EventWidget(
                            event: state[index],
                            updateEvent: ReadContext(_globalKey.currentContext!)
                                .read<EventListCubit>()
                                .updateEvent,
                          );
                        }
                      } else {
                        return EventWidget(
                          event: state[index],
                          updateEvent: ReadContext(_globalKey.currentContext!)
                              .read<EventListCubit>()
                              .updateEvent,
                        );
                      }
                    }()),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _longPressHandler(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) {
        if (event.textData != null) {
          return EventDialog(
            event: event,
            deleteEvent: ReadContext(_globalKey.currentContext!)
                .read<EventListCubit>()
                .deleteEvent,
            updateEvent: ReadContext(_globalKey.currentContext!)
                .read<EventListCubit>()
                .updateEvent,
            updateChat: _updateListDelegate,
            getChats: _getChatsDelegate,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
