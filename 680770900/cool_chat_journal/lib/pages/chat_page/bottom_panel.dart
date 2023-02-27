import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/category.dart';
import '../../model/event.dart';
import 'category_view.dart';

class BottomPanel extends StatefulWidget {
  final int chatIndex;
  final VoidCallback? resetSelection;
  final String? textFieldValue;
  final int? editEventIndex;

  const BottomPanel({
    required this.chatIndex,
    this.resetSelection,
    this.textFieldValue,
    this.editEventIndex,  
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _textFocusNode = FocusNode();
  final _textController = TextEditingController();
  var _showCategories = false;
  Category? _selectedCategory;

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
    final source= await _showImageDialog();

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        context.read<ChatsCubit>()
          .addEvent(widget.chatIndex, Event(
            content: image.path,
            isImage: true,
            changeTime: DateTime.now(),
          ));
      }
    }
  }

  void _onEnterText() {
    final editEventIndex = widget.editEventIndex;

    if (editEventIndex == null) {
      context.read<ChatsCubit>()
        .addEvent(widget.chatIndex, Event(
          content: _textController.text,
          changeTime: DateTime.now(),
          category: _selectedCategory,
        ));
    } else {
      final oldEvent = context.read<ChatsCubit>()
        .state.chats[widget.chatIndex].events[editEventIndex];
      context.read<ChatsCubit>()
        .editEvent(widget.chatIndex, editEventIndex, oldEvent.copyWith(
          content: _textController.text,
          category: _selectedCategory,
        ));
    }

    _showCategories = false;
    _selectedCategory = null;

    widget.resetSelection?.call();

    _textFocusNode.unfocus();
    _textController.clear();
  }

  Widget _createCategoriesButton() {
    final IconData icon;
    if (_selectedCategory != null) {
      icon = _selectedCategory!.icon;
    } else {
      icon = Icons.widgets_rounded;
    }

    return IconButton(
      icon: Icon(icon),
      onPressed: () => setState(() => _showCategories = !_showCategories),
    );
  }

  Widget _createTextField() {
    return Expanded(
      child: _EventField(
        textFieldValue: widget.textFieldValue,
        focusNode: _textFocusNode,
        controller: _textController,
        onSubmitted: (_) => _onEnterText(),
      ),
    );
  }

  Widget _createSendButton() {
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
  }

  Widget _createCategoriesList() {
    final categories = AvailableCategories.categories;
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() {
              _selectedCategory = null;
              _showCategories = false;
            }),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CategoryView(
                category: Category(
                  name: 'Cancel',
                  icon: Icons.cancel,
                ),
              ),
            ),
          ),
      
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => setState(() {
                  _selectedCategory = categories[index];
                  _showCategories = false;
                }),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CategoryView(
                    category: categories[index],
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

    if (widget.textFieldValue != null) {
      _textController.text = widget.textFieldValue!;
    }

    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_showCategories)
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
