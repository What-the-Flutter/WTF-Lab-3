import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/chat_cubit.dart';
import '../models/models.dart';

class BottomPanel extends StatefulWidget {
  final Chat chat;
  final Event? sourceEvent;

  const BottomPanel({
    required this.chat,
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

        context.read<ChatCubit>().addNewEvent(
          Event(
            content: base64Image,
            isImage: true,
            changeTime: DateTime.now(),
            category: context.read<ChatCubit>().state.selectedCategory,
          ),
        );
      }
    }
  }

  void _onEnterText() {
    final chatCubit = context.read<ChatCubit>();
    final sourceEvent = widget.sourceEvent;
    if (sourceEvent == null) {
      chatCubit.addNewEvent(
        Event(
          content: _textController.text,
          changeTime: DateTime.now(),
          category: chatCubit.state.selectedCategory,
        ),
      );
    } else {
      chatCubit.editEvent(
        sourceEvent.id,
        sourceEvent.copyWith(
          content: _textController.text,
          category: chatCubit.state.selectedCategory,
        ),
      );
    }

    if (chatCubit.state.isEditMode) {
      chatCubit.toggleEditMode();
    }

    chatCubit.changeShowCategories(false);
    chatCubit.selectCategory(null);
    chatCubit.resetSelection();

    _textController.clear();
    _textFocusNode.unfocus();
  }

  Widget _createCategoriesButton() {
    final chatCubit = context.read<ChatCubit>();
    final selectedCategory = chatCubit.state.selectedCategory;
    final IconData icon;
    if (selectedCategory != null) {
      icon = selectedCategory.icon;
    } else {
      icon = Icons.widgets_rounded;
    }

    final showCategories = chatCubit.state.showCategories;

    return IconButton(
      icon: Icon(icon),
      onPressed: () => chatCubit.changeShowCategories(!showCategories),
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
    final categories = Category.values;
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.read<ChatCubit>().selectCategory(null);
              context.read<ChatCubit>().changeShowCategories(false);
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
                  context.read<ChatCubit>().changeShowCategories(false);
                  context.read<ChatCubit>().selectCategory(categories[index]);   
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(categories[index].icon),
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
