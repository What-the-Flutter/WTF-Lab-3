import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_app_bar.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_body.dart';

class EventScreen extends StatefulWidget {
  final int chatId;
  final String title;

  const EventScreen({
    super.key,
    required this.chatId,
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
  }

  @override
  void dispose() {
    super.dispose();
    controllerSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final listSearch = context.read<EventCubit>().searchListEvent(widget.chatId);
        final listEvent =
            state.listEvent.reversed.where((element) => element.chatId == widget.chatId).toList();
        return Scaffold(
          appBar: EventScreenAppBar(
            eventState: state,
            listEvent: listEvent,
            title: widget.title,
            controller: controllerSearch,
          ),
          body: EventScreenBody(
            isFavorite: state.isFavorite,
            isSelected: state.isSelected,
            listEvent: state.isSearch ? listSearch : listEvent,
            title: widget.title,
            isSearch: state.isSearch,
            chatId: widget.chatId,
          ),
        );
      },
    );
  }
}
