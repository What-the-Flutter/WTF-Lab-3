import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/add_page_screen/add_page_app_bar.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_body.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_floating_button.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';

class AddNewScreen extends StatefulWidget {
  final String textController;
  final int editIndex;

  const AddNewScreen({
    super.key,
    required this.textController,
    this.editIndex = -1,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  bool isStatus = false;
  late final TextEditingController inputController;

  @override
  void initState() {
    inputController = TextEditingController(text: widget.textController);
    inputController.addListener(listenerController);
    super.initState();
  }

  @override
  void dispose() {
    inputController.removeListener(listenerController);
    inputController.dispose();
    super.dispose();
  }

  void listenerController() {
    setState(
      () {
        if (inputController.text.isNotEmpty) {
          isStatus = true;
        } else {
          isStatus = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final editMode = state.isEdit;
        final selectedIcon = state.iconSeleted;
        return Scaffold(
          appBar: AddPageAppBar(
            status: editMode,
          ),
          body: AddPageBody(
            controller: inputController,
            selectedIcon: selectedIcon,
          ),
          floatingActionButton: AddPageFloatingButton(
            status: isStatus,
            selected: selectedIcon,
            controller: inputController,
            editMode: editMode,
            editIndex: widget.editIndex,
          ),
        );
      },
    );
  }
}
