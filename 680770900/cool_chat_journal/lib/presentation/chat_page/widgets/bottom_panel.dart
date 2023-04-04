import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hashtagable/functions.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/models.dart';
import '../../../utils/custom_theme.dart';
import '../../../utils/null_wrapper.dart';
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
  final _cubit = GetIt.I<ChatCubit>();

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

  void _onAddImage({
    required String? selectedCategoryId,
  }) async {
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
          categoryId: selectedCategoryId,
        );

        _cubit.addNewEvent(event);
      }
    }
  }

  void _onAddText({
    required String? selectedCategoryId,
  }) {
    _cubit.addNewEvent(
      Event(
        chatId: widget.chatId,
        content: _textController.text,
        isFavorite: false,
        changeTime: DateTime.now(),
        categoryId: selectedCategoryId,
      ),
    );
  }

  void _onEditText({
    required Event sourceEvent,
    required String? selectedCategoryId,
  }) {
    final NullWrapper<String?>? selectedCategory;
    if (selectedCategoryId != null) {
      selectedCategory = NullWrapper<String?>(selectedCategoryId);
    } else {
      selectedCategory = null;
    }

    _cubit.editEvent(
      sourceEvent.copyWith(
        content: NullWrapper<String?>(_textController.text),
        categoryId: selectedCategory,
      ),
    );
  }

  void _clearView({
    required bool isEditMode,
  }) {
    if (isEditMode) {
      _cubit.removeEditedEvent();
    }

    _cubit.changeShowCategories(false);
    _cubit.selectCategory(null);
    _cubit.resetSelection();

    _textController.clear();
    _textFocusNode.unfocus();
  }

  void _onEnterText({
    required String? selectedCategoryId,
    required bool isEditMode,
  }) {
    final sourceEvent = widget.sourceEvent;

    if (sourceEvent == null) {
      _onAddText(
        selectedCategoryId: selectedCategoryId,
      );
    } else {
      _onEditText(
        sourceEvent: sourceEvent,
        selectedCategoryId: selectedCategoryId,
      );
    }

    _clearView(
      isEditMode: isEditMode,
    );
  }

  Widget _textField({
    required String? selectedCategoryId,
    required bool isEditMode,
  }) {
    return Expanded(
      child: _EventField(
        focusNode: _textFocusNode,
        controller: _textController,
        onSubmitted: (_) => _onEnterText(
          selectedCategoryId: selectedCategoryId,
          isEditMode: isEditMode,
        ),
      ),
    );
  }

  Widget _sendButton({
    required String? selectedCategoryId,
    required bool isEditMode,
  }) {
    return AnimatedCrossFade(
      crossFadeState: _textController.text.isNotEmpty
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: IconButton(
        icon: const Icon(Icons.send_rounded),
        onPressed: () => _onEnterText(
          selectedCategoryId: selectedCategoryId,
          isEditMode: isEditMode,
        ),
      ),
      secondChild: IconButton(
        icon: const Icon(Icons.add_a_photo_outlined),
        onPressed: () => _onAddImage(
          selectedCategoryId: selectedCategoryId,
        ),
      ),
      duration: const Duration(milliseconds: 200),
    );
  }

  void _onChangeText() {
    final text = _textController.text;
    _cubit.changeText(text);

    if (text.endsWith('#')) {
      _cubit.changeShowTags(true);
    } else if (text.endsWith(' ')) {
      _cubit.changeShowTags(false);
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
          color: CustomTheme.of(context).themeData.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.showTags && hasHashTags(_textController.text))
                _TagsList(text: _textController.text),
              if (state.showCategories) const _CategoriesList(),
              Row(
                children: [
                  const _CategoriesButton(),
                  _textField(
                    selectedCategoryId: state.selectedCategoryId,
                    isEditMode: state.editedEvent != null,
                  ),
                  _sendButton(
                    selectedCategoryId: state.selectedCategoryId,
                    isEditMode: state.editedEvent != null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoriesButton extends StatefulWidget {
  const _CategoriesButton({super.key});

  @override
  State<_CategoriesButton> createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends State<_CategoriesButton> {
  final _cubit = GetIt.I<ChatCubit>();
  IconData _icon({
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
      builder: (_, state) {
        final selectedCategory = state.selectedCategoryId;

        final icon = _icon(
          selectedCategory: selectedCategory,
          categories: state.categories,
        );

        final showCategories = state.showCategories;

        return IconButton(
          icon: Icon(icon),
          onPressed: () => _cubit.changeShowCategories(!showCategories),
        );
      },
    );
  }
}

class _CategoriesList extends StatefulWidget {
  const _CategoriesList({super.key});

  @override
  State<_CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<_CategoriesList> {
  final _cubit = GetIt.I<ChatCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (_, state) => SizedBox(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _cubit.selectCategory(null);
                _cubit.changeShowCategories(false);
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
                itemCount: state.categories.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    _cubit.changeShowCategories(false);
                    _cubit.selectCategory(state.categories[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconData(
                            state.categories[index].icon,
                            fontFamily: 'MaterialIcons',
                          ),
                        ),
                        Text(state.categories[index].title),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagsList extends StatefulWidget {
  final String text;

  const _TagsList({
    super.key,
    required this.text,
  });

  @override
  State<_TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<_TagsList> {
  final _cubit = GetIt.I<ChatCubit>();

  List<Tag> _generateTags({
    required List<Tag> availableTags,
  }) {
    final inputTag = extractHashTags(widget.text).last;

    return availableTags
        .where((tag) => '#${tag.id}'.startsWith(inputTag))
        .toList();
  }

  void _insertTag({
    required Tag tag,
    required String text,
  }) {
    final hashtagIndex = text.lastIndexOf('#');
    final substring = text.substring(0, hashtagIndex);
    _cubit.changeText('$substring#${tag.id}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (_, state) {
        final tags = _generateTags(
          availableTags: state.tags,
        );

        if (tags.isNotEmpty) {
          return SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(tags[index].id),
                  onPressed: () => _insertTag(
                    tag: tags[index],
                    text: state.text!,
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
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
