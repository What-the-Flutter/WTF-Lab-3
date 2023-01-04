import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/copy_message_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/delete_button.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_modal.dart';
import 'package:my_final_project/ui/widgets/event_screen/favorite_button.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';

class EventScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EventState eventState;
  final List<Event> listEvent;
  final String title;
  final TextEditingController controller;

  const EventScreenAppBar({
    super.key,
    required this.eventState,
    required this.listEvent,
    required this.title,
    required this.controller,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    if (eventState.isSelected) {
      return AppBar(
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
                    listEvent: listEvent,
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
                  onPressed: () => context.read<EventCubit>().changeEditText(),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          !eventState.isPicter && eventState.countSelected < 2
              ? CopyMessageButton(listMessage: listEvent)
              : const SizedBox(),
          const DeleteButton(),
          const FavoriteButton(),
        ],
      );
    } else if (eventState.isSearch) {
      return AppBar(
        leading: TextButton(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.read<EventCubit>().changeSearch();
            context.read<HomeCubit>().updateInfo();
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          controller: controller,
          onChanged: (value) => BlocProvider.of<EventCubit>(context).searchText(value),
          decoration: const InputDecoration(
            filled: true,
            border: InputBorder.none,
            hintText: 'Search',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<EventCubit>().changeSearch();
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else {
      return AppBar(
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
        title: Text(title),
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
      );
    }
  }
}
