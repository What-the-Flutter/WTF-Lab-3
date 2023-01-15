import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/data/database/chat_database.dart';
import '../../../common/models/tag.dart';
import '../../../common/utils/insets.dart';
import '../../chat/widget/tag_selector/tag_item.dart';
import '../../theme/widget/color_selector.dart';
import '../cubit/manage_tags_cubit.dart';

class ManageTagsPage extends StatelessWidget {
  const ManageTagsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageTagsCubit(
        messageProviderApi: context.read<ChatDatabase>(),
      ),
      child: BlocBuilder<ManageTagsCubit, ManageTagsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Manage tags'),
              leading: BackButton(
                onPressed: () {
                  state.maybeMap(
                    initial: (initial) {
                      context.pop();
                    },
                    orElse: () {
                      context.read<ManageTagsCubit>().backToDefault();
                    },
                  );
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(Insets.large),
              child: Builder(
                builder: (context) {
                  return state.map(
                    initial: (initial) {
                      return _PageSelectionBody(
                        tags: initial.tags,
                      );
                    },
                    addingMode: (addingMode) {
                      return _PageAddEditBody(
                        tagForEdit: addingMode.newTag,
                      );
                    },
                    editingMode: (editingMode) {
                      return _PageAddEditBody(
                        tagForEdit: editingMode.editableTag,
                      );
                    },
                    selectionMode: (selectionMode) {
                      return _PageSelectionBody(
                        tags: selectionMode.tags,
                        selectedId: selectionMode.selectedTag,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PageSelectionBody extends StatelessWidget {
  const _PageSelectionBody({
    super.key,
    required this.tags,
    this.selectedId,
  });

  final int? selectedId;
  final IList<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageTags(
          tags: tags,
          selectedId: selectedId,
        ),
        const Spacer(),
        Row(
          children: [
            TextButton(
              onPressed: selectedId == null
                  ? null
                  : context.read<ManageTagsCubit>().remove,
              child: const Text('remove'),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: selectedId == null
                  ? context.read<ManageTagsCubit>().startAddingMode
                  : context.read<ManageTagsCubit>().startEditingMode,
              child: Text(
                selectedId == null ? 'add' : 'edit',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PageAddEditBody extends StatefulWidget {
  const _PageAddEditBody({
    super.key,
    required this.tagForEdit,
  });

  final Tag tagForEdit;

  @override
  State<_PageAddEditBody> createState() => _PageAddEditBodyState();
}

class _PageAddEditBodyState extends State<_PageAddEditBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.tagForEdit.text;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          onChanged: (text) {
            context.read<ManageTagsCubit>().updateTag(text: text);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: TagItem(
            color: widget.tagForEdit.color,
            text: widget.tagForEdit.text,
          ),
        ),
        ColorSelector(
          onTap: (color) {
            context.read<ManageTagsCubit>().updateTag(color: color);
          },
          selectedColor: widget.tagForEdit.color,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: context.read<ManageTagsCubit>().applyChanges,
              child: const Text('apply'),
            ),
          ],
        ),
      ],
    );
  }
}

class MessageTags extends StatelessWidget {
  const MessageTags({
    super.key,
    required this.tags,
    this.selectedId,
  });

  final IList<Tag> tags;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Insets.medium,
      runSpacing: Insets.medium,
      children: tags.map(
        (tag) {
          return TagItem(
            color: tag.color,
            text: tag.text,
            isSelected: selectedId == tag.id,
            onPressed: (isSelected) {
              context.read<ManageTagsCubit>().onTagPressed(tag);
            },
          );
        },
      ).toList(),
    );
  }
}
