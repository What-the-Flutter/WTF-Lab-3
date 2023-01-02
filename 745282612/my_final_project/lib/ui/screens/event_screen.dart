import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/copy_message_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/delete_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_body.dart';
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
  String pasteValue = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventCubit>(context).initializer(widget.listEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final stateEvent = context.watch<EventCubit>().state;
        final listEvent = stateEvent.listEvent;
        final isFavorite = stateEvent.isFavorite;
        final isSelected = stateEvent.isSelected;
        return Scaffold(
          appBar: isSelected
              ? AppBar(
                  leading: TextButton(
                    onPressed: () =>
                        context.read<EventCubit>().changeSelected(),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    !stateEvent.isPicter
                        ? TextButton(
                            onPressed: () =>
                                context.read<EventCubit>().changeEditText(),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                    !stateEvent.isPicter
                        ? CopyMessageButton(listMessage: widget.listEvent)
                        : const SizedBox(),
                    const DeleteButton(),
                    const FavoriteButton(),
                  ],
                )
              : AppBar(
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
                      onPressed: () {},
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<EventCubit>().changeFavorite(),
                      child: Icon(
                        isFavorite ? Icons.turned_in : Icons.turned_in_not,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
          body: EventScreenBody(
            isFavorite: isFavorite,
            isSelected: isSelected,
            listEvent: listEvent,
            title: widget.title,
          ),
        );
      },
    );
  }
}
