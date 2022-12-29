import 'package:flutter/material.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_app_bar.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_body.dart';
import 'package:my_final_project/ui/widgets/add_page_screen/add_page_floating_button.dart';
import 'package:provider/provider.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();

  static _AddNewScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_AddNewScreenState>()!;
}

class _AddNewScreenState extends State<AddNewScreen> {
  bool isStatus = false;
  Icon? selectedIcon;
  final inputController = TextEditingController();

  @override
  void initState() {
    inputController.addListener(listenerController);
    super.initState();
  }

  void changeSelectedIcon(Icon? icon) {
    setState(
      () {
        selectedIcon = icon;
      },
    );
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
    final editMode = Provider.of<ProviderChat>(context).isEditeMode;
    final editController = Provider.of<ProviderChat>(context).inputController;

    return Scaffold(
      appBar: AddPageAppBar(
        status: editMode,
      ),
      floatingActionButton: AddPageFloatingButton(
        status: isStatus,
        selected: selectedIcon,
        editStatus: editMode,
        controller: editMode ? editController : inputController,
      ),
      body: AddPageBody(
        controller: editMode ? editController : inputController,
      ),
    );
  }
}
