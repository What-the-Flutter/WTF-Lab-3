import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_app_bar.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_body.dart';

class EventScreen extends StatefulWidget {
  final List<Event> listEvent;
  final String title;

  const EventScreen({
    super.key,
    required this.listEvent,
    required this.title,
  });

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final TextEditingController controllerSearch;

  @override
  void initState() {
    super.initState();
    controllerSearch = TextEditingController();
    BlocProvider.of<EventCubit>(context).initializer(widget.listEvent);
  }

  @override
  void dispose() {
    super.dispose();
    controllerSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final stateEvent = context.watch<EventCubit>().state;
        final listSearch = context.read<EventCubit>().searchListEvent();
        return Scaffold(
          appBar: EventScreenAppBar(
            eventState: stateEvent,
            listEvent: widget.listEvent,
            title: widget.title,
            controller: controllerSearch,
          ),
          body: EventScreenBody(
            isFavorite: stateEvent.isFavorite,
            isSelected: stateEvent.isSelected,
            listEvent: stateEvent.isSearch ? listSearch : stateEvent.listEvent,
            title: widget.title,
            isSearch: stateEvent.isSearch,
          ),
        );
      },
    );
  }
}
