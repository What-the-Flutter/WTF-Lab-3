import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_app_bar.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_body.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_floating_button.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';

class AddNewScreen extends StatefulWidget {
  final String textController;
  final Chat? chat;

  const AddNewScreen({
    super.key,
    required this.textController,
    this.chat,
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
        final stateSetting = context.watch<SettingsCubit>().state;
        return Scaffold(
          appBar: AddPageAppBar(
            status: state.isEdit,
            addSectionMode: stateSetting.isAdd,
          ),
          body: AddPageBody(
            controller: inputController,
            selectedIcon: state.iconSeleted,
          ),
          floatingActionButton: AddPageFloatingButton(
            addSectionMode: stateSetting.isAdd,
            status: isStatus,
            selected: state.iconSeleted,
            controller: inputController,
            editMode: state.isEdit,
            chat: widget.chat,
          ),
        );
      },
    );
  }
}
