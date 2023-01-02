import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';

class AddPageFloatingButton extends StatelessWidget {
  final bool status;
  final Icon? selected;
  final TextEditingController controller;
  final bool editMode;
  final int editIndex;

  const AddPageFloatingButton({
    super.key,
    required this.status,
    required this.selected,
    required this.controller,
    required this.editMode,
    required this.editIndex,
  });

  @override
  Widget build(BuildContext context) {
    final result = controller.text.isNotEmpty && selected != null;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return FloatingActionButton(
          child: Icon(result ? Icons.add : Icons.close),
          onPressed: () {
            if (result) {
              editMode
                  ? context.read<HomeCubit>().editChat(
                      icon: selected!, title: controller.text, index: editIndex)
                  : context
                      .read<HomeCubit>()
                      .addChat(icon: selected!, title: controller.text);
            }
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
