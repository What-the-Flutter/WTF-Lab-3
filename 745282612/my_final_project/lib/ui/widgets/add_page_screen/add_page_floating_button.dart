import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';

class AddPageFloatingButton extends StatefulWidget {
  final bool status;
  final Icon? selected;
  final TextEditingController controller;
  final bool editMode;
  final Chat? chat;
  final bool addSectionMode;

  const AddPageFloatingButton({
    super.key,
    required this.status,
    required this.selected,
    required this.controller,
    required this.editMode,
    required this.addSectionMode,
    this.chat,
  });

  @override
  State<AddPageFloatingButton> createState() => _AddPageFloatingButtonState();
}

class _AddPageFloatingButtonState extends State<AddPageFloatingButton> {
  void changeOnPressed() {
    if (widget.addSectionMode) {
      context
          .read<SettingCubit>()
          .addSection(iconData: widget.selected!.icon!, title: widget.controller.text);
      context.read<SettingCubit>().changeAddStatus();
    } else if (widget.editMode) {
      context
          .read<HomeCubit>()
          .editChat(icon: widget.selected!, title: widget.controller.text, chat: widget.chat!);
    } else {
      context.read<HomeCubit>().addChat(icon: widget.selected!, title: widget.controller.text);
    }
    context.read<HomeCubit>().changeIconSelected();
  }

  void changeStatus() {
    if (widget.addSectionMode) {
      context.read<SettingCubit>().changeAddStatus();
    } else if (widget.editMode) {
      context.read<HomeCubit>().changeEditMode();
    }
    context.read<HomeCubit>().changeIconSelected();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.controller.text.isNotEmpty && widget.selected != null;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return FloatingActionButton(
          child: Icon(result ? Icons.add : Icons.close),
          onPressed: () {
            if (result) {
              changeOnPressed();
            } else {
              changeStatus();
            }
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
