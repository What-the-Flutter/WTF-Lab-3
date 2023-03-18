import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/models.dart';
import '../chat_cubit.dart';

class BottomPanel extends StatefulWidget {
  final String chatId;
  final Event? sourceEvent;

  const BottomPanel({
    required this.chatId,
    this.sourceEvent,
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _textFocusNode = FocusNode();
  final _textController = TextEditingController();

  Future<ImageSource?> _showImageDialog() {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text('Choose image source'), actions: [
        ElevatedButton(
          child: const Text('Camera'),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        ElevatedButton(
          child: const Text('Gallery'),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    );
  }

  void _onAddImage() async {
    final source = await _showImageDialog();

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        final imageBytes = await image.readAsBytes();
        final base64Image = base64Encode(imageBytes);
        final cubit = context.read<ChatCubit>();

        cubit.addNewEvent(
          Event(
            chatId: widget.chatId,
            content: base64Image,
            isImage: true,
            isFavorite: false,
            changeTime: DateTime.now(),
            categoryId: cubit.state.selectedCategoryId,
          ),
        );
      }
    }
  }

  void _onEnterText() {
    final cubit = context.read<ChatCubit>();
    final sourceEvent = widget.sourceEvent;
    if (sourceEvent == null) {
      cubit.addNewEvent(
        Event(
          chatId: widget.chatId,
          content: _textController.text,
          isImage: false,
          isFavorite: false,
          changeTime: DateTime.now(),
          categoryId: cubit.state.selectedCategoryId,
        ),
      );
    } else {
      final NullWrapper<String?>? selectedCategory;
      if (cubit.state.selectedCategoryId != null) {
        selectedCategory =
          NullWrapper<String?>(cubit.state.selectedCategoryId);
      } else {
        selectedCategory = null;
      }

      cubit.editEvent(
        sourceEvent.copyWith(
          content: _textController.text,
          categoryId: selectedCategory,
        ),
      );
    }

    if (cubit.state.isEditMode) {
      cubit.toggleEditMode();
    }

    cubit.changeShowCategories(false);
    cubit.selectCategory(null);
    cubit.resetSelection();

    _textController.clear();
    _textFocusNode.unfocus();
  }

  Widget _createCategoriesButton() {
    final cubit = context.read<ChatCubit>();
    final selectedCategory = cubit.state.selectedCategoryId;
    final IconData icon;
    if (selectedCategory != null) {
      final category = cubit.state.categories.firstWhere(
        (category) => category.id == selectedCategory,
      );

      icon = IconData(category.icon, fontFamily: 'MaterialIcons');  
    } else {
      icon = Icons.widgets_rounded;
    }

    final showCategories = cubit.state.showCategories;

    return IconButton(
      icon: Icon(icon),
      onPressed: () => cubit.changeShowCategories(!showCategories),
    );
  }

  Widget _createTextField() {
    return Expanded(
      child: _EventField(
        focusNode: _textFocusNode,
        controller: _textController,
        onSubmitted: (_) => _onEnterText(),
      ),
    );
  }

  Widget _createSendButton() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (_textController.text.isNotEmpty) {
          return IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: _onEnterText,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            onPressed: _onAddImage,
          );
        }
      },
    );
  }

  Widget _createCategoriesList() {
    final cubit = context.read<ChatCubit>();
    final categories = cubit.state.categories;
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              cubit.selectCategory(null);
              cubit.changeShowCategories(false);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cancel),
                  const Text('Cancel'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  cubit.changeShowCategories(false);
                  cubit.selectCategory(categories[index].id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconData(
                          categories[index].icon,
                          fontFamily: 'MaterialIcons',
                        ),
                      ),
                      Text(categories[index].title),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _textController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (context.read<ChatCubit>().state.showCategories)
          _createCategoriesList(),
        Row(
          children: [
            _createCategoriesButton(),
            _createTextField(),
            _createSendButton(),
          ],
        ),
      ],
    );
  }
}

class _EventField extends StatelessWidget {
  final String? textFieldValue;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;

  const _EventField({
    this.textFieldValue,
    this.focusNode,
    required this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Enter event',
      ),
      onSubmitted: onSubmitted,
    );
  }
}
