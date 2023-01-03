import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/copy_message_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/delete_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_body.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_modal.dart';
import 'package:my_final_project/ui/widgets/event_screen/favorite_button.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';

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
  final eventCubit = EventCubit();
  String pasteValue = '';
  late final TextEditingController controllerSearch;
  List<Event> listSearch = [];

  // void searchEvent() {
  //   final searchText = controllerSearch.text;
  //   if (searchText.isEmpty) {
  //     listSearch = widget.listEvent;
  //   } else {
  //     listSearch = widget.listEvent
  //         .where((element) =>
  //             element.messageContent.toLowerCase().contains(searchText))
  //         .toList();
  //   }
  //   setState(() {});
  // }

  void _changed() {
    eventCubit.searchElement(controllerSearch.text);
  }

  @override
  void initState() {
    super.initState();
    listSearch = widget.listEvent;
    controllerSearch = TextEditingController();
    controllerSearch.addListener(_changed);
    BlocProvider.of<EventCubit>(context).initializer(widget.listEvent);
  }

  @override
  void dispose() {
    super.dispose();
    controllerSearch.dispose();
    controllerSearch.removeListener(_changed);
  }

  PreferredSizeWidget appBar({
    required EventState eventState,
  }) {
    if (eventState.isSelected) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context.read<EventCubit>().changeSelected(),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                eventState.countSelected.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return EventScreenModal(
                      listEvent: widget.listEvent,
                    );
                  },
                );
              },
              child: const Icon(
                Icons.reply,
                color: Colors.white,
              ),
            ),
            !eventState.isPicter && eventState.countSelected < 2
                ? TextButton(
                    onPressed: () =>
                        context.read<EventCubit>().changeEditText(),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
            !eventState.isPicter && eventState.countSelected < 2
                ? CopyMessageButton(listMessage: widget.listEvent)
                : const SizedBox(),
            const DeleteButton(),
            const FavoriteButton(),
          ],
        ),
      );
    } else if (eventState.isSearch) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: TextButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<HomeCubit>().updateInfo();
              Navigator.of(context).pop();
            },
          ),
          title: TextField(
            controller: controllerSearch,
            decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              hintText: 'Search',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.read<EventCubit>().changeSearch(),
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: TextButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<HomeCubit>().updateInfo();
              Navigator.of(context).pop();
            },
          ),
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () => context.read<EventCubit>().changeSearch(),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () => context.read<EventCubit>().changeFavorite(),
              child: Icon(
                eventState.isFavorite ? Icons.turned_in : Icons.turned_in_not,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final stateEvent = context.watch<EventCubit>().state;
        return Scaffold(
          appBar: appBar(
            eventState: stateEvent,
          ),
          body: EventScreenBody(
            isFavorite: stateEvent.isFavorite,
            isSelected: stateEvent.isSelected,
            listEvent: stateEvent.listEvent,
            // stateEvent.isSearch ? listSearch :
            title: widget.title,
            isSearch: stateEvent.isSearch,
          ),
        );
      },
    );
  }
}
