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
        final cubit = context.read<ChatCubit>();

        final event = Event(
          chatId: widget.chatId,
          image: imageBytes,
          isFavorite: false,
          changeTime: DateTime.now(),
          categoryId: cubit.state.selectedCategoryId,
        );

        cubit.addNewEvent(event);
      }
    }
  }

  void _onAddText() {
    final cubit = context.read<ChatCubit>();
    cubit.addNewEvent(
      Event(
        chatId: widget.chatId,
        content: _textController.text,
        isFavorite: false,
        changeTime: DateTime.now(),
        categoryId: cubit.state.selectedCategoryId,
      ),
    );
  }

  void _onEditText(Event sourceEvent) {
    final cubit = context.read<ChatCubit>();

    final NullWrapper<String?>? selectedCategory;
    if (cubit.state.selectedCategoryId != null) {
      selectedCategory = NullWrapper<String?>(cubit.state.selectedCategoryId);
    } else {
      selectedCategory = null;
    }

    cubit.editEvent(
      sourceEvent.copyWith(
        content: NullWrapper<String?>(_textController.text),
        categoryId: selectedCategory,
      ),
    );
  }

  void _clearView() {
    final cubit = context.read<ChatCubit>();

    if (cubit.state.isEditMode) {
      cubit.toggleEditMode();
    }

    cubit.changeShowCategories(false);
    cubit.selectCategory(null);
    cubit.resetSelection();

    _textController.clear();
    _textFocusNode.unfocus();
  }

  void _onEnterText() {
    final sourceEvent = widget.sourceEvent;

    if (sourceEvent == null) {
      _onAddText();
    } else {
      _onEditText(sourceEvent);
    }

    _clearView();
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

  void _onChangeText() {
    final cubit = context.read<ChatCubit>();

    final text = _textController.text;
    cubit.changeText(text);

    if (text.endsWith('#')) {
      cubit.changeShowTags(true);
    } else if (text.endsWith(' ')) {
      cubit.changeShowTags(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onChangeText);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.text != null) {
          _textController.text = state.text!;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        }

        return Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.showTags) const _TagsList(),
              if (state.showCategories) const _CategoriesList(),
              Row(
                children: [
                  const _CategoriesButton(),
                  _createTextField(),
                  _createSendButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoriesButton extends StatelessWidget {
  const _CategoriesButton({super.key});

  IconData _createIcon({
    String? selectedCategory, 
    required List<Category> categories,
  }) {
    final IconData icon;
    if (selectedCategory != null) {
      final category = categories.firstWhere(
        (category) => category.id == selectedCategory,
      );
      icon = IconData(category.icon, fontFamily: 'MaterialIcons');
    } else {
      icon = Icons.widgets_rounded;
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final selectedCategory = state.selectedCategoryId;
        
        final icon = _createIcon(
          selectedCategory: selectedCategory,
          categories: state.categories,
        );

        final showCategories = state.showCategories;

        return IconButton(
          icon: Icon(icon),
          onPressed: () => 
            context.read<ChatCubit>().changeShowCategories(!showCategories),
        );
      },
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    final categories = cubit.state.categories;
    return SizedBox(
      height: 70,
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
}

class _TagsList extends StatelessWidget {
  const _TagsList({super.key});

  List<Tag> _generateTags(List<Tag> tags) {
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    final tags = _generateTags(cubit.state.tags);

    if (tags.isNotEmpty) {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(tags[index].value),
              onPressed: () {
                final text = '${cubit.state.text}${tags[index].value} ';
                cubit.changeText(text);
              },
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: const Text('+ Add new tag'),
          onPressed: () {
            cubit.addNewTag(
              Tag(
                value: '#test',
                count: 1,  
              ),
            );
            cubit.changeShowTags(false);
          },
        ),
      );
    }
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
