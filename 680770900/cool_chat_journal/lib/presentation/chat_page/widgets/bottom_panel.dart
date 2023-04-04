import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hashtagable/functions.dart';
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

        final event = Event(
          chatId: widget.chatId,
          image: imageBytes,
          isFavorite: false,
          changeTime: DateTime.now(),
          categoryId: GetIt.I<ChatCubit>().state.selectedCategoryId,
        );

        GetIt.I<ChatCubit>().addNewEvent(event);
      }
    }
  }

  void _onAddText() {
    GetIt.I<ChatCubit>().addNewEvent(
      Event(
        chatId: widget.chatId,
        content: _textController.text,
        isFavorite: false,
        changeTime: DateTime.now(),
        categoryId: GetIt.I<ChatCubit>().state.selectedCategoryId,
      ),
    );
  }

  void _onEditText(Event sourceEvent) {
    final NullWrapper<String?>? selectedCategory;
    if (GetIt.I<ChatCubit>().state.selectedCategoryId != null) {
      selectedCategory =
          NullWrapper<String?>(GetIt.I<ChatCubit>().state.selectedCategoryId);
    } else {
      selectedCategory = null;
    }

    GetIt.I<ChatCubit>().editEvent(
      sourceEvent.copyWith(
        content: NullWrapper<String?>(_textController.text),
        categoryId: selectedCategory,
      ),
    );
  }

  void _clearView() {
    if (GetIt.I<ChatCubit>().state.isEditMode) {
      GetIt.I<ChatCubit>().toggleEditMode();
    }

    GetIt.I<ChatCubit>().changeShowCategories(false);
    GetIt.I<ChatCubit>().selectCategory(null);
    GetIt.I<ChatCubit>().resetSelection();

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
    final text = _textController.text;
    GetIt.I<ChatCubit>().changeText(text);

    if (text.endsWith('#')) {
      GetIt.I<ChatCubit>().changeShowTags(true);
    } else if (text.endsWith(' ')) {
      GetIt.I<ChatCubit>().changeShowTags(false);
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
              if (state.showTags && hasHashTags(_textController.text))
                _TagsList(text: _textController.text),
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
              GetIt.I<ChatCubit>().changeShowCategories(!showCategories),
        );
      },
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = GetIt.I<ChatCubit>().state.categories;
    return SizedBox(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              GetIt.I<ChatCubit>().selectCategory(null);
              GetIt.I<ChatCubit>().changeShowCategories(false);
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
                  GetIt.I<ChatCubit>().changeShowCategories(false);
                  GetIt.I<ChatCubit>().selectCategory(categories[index].id);
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
  final String text;
  const _TagsList({
    super.key,
    required this.text,
  });

  List<Tag> _generateTags() {
    final inputTag = extractHashTags(text).last;

    return GetIt.I<ChatCubit>()
        .state
        .tags
        .where((tag) => '#${tag.id}'.startsWith(inputTag))
        .toList();
  }

  void _insertTag(Tag tag) {
    final text = GetIt.I<ChatCubit>().state.text!;
    final hashtagIndex = text.lastIndexOf('#');

    final substring = text.substring(0, hashtagIndex);
    GetIt.I<ChatCubit>().changeText('$substring#${tag.id}');
  }

  @override
  Widget build(BuildContext context) {
    final tags = _generateTags();

    if (tags.isNotEmpty) {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(tags[index].id),
              onPressed: () => _insertTag(tags[index]),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
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
