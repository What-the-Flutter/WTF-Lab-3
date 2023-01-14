import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/api/chat_provider_api.dart';
import '../../../../common/api/message_provider_api.dart';
import '../../../../common/data/chat_repository.dart';
import '../../../../common/data/database/chat_database.dart';
import '../../../../common/utils/insets.dart';
import '../../../../common/utils/radius.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../../cubit/tag_selector/tags_cubit.dart';
import '../../cubit/tag_selector/tags_state.dart';
import '../../data/message_repository.dart';
import '../scopes/message_input_scope.dart';
import '../scopes/tags_scope.dart';
import '../tag_selector/tag_selector.dart';

part 'input_mutable_button.dart';

part 'selected_images.dart';

class ChatInput extends StatefulWidget {
  ChatInput({
    super.key,
    required this.chatId,
  });

  final int chatId;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isTagAddingOpened = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatRepository>().chats.value.firstWhere(
          (chat) => chat.id == widget.chatId,
        );

    return MessageInputScope(
      repository: MessageRepository(
        repository: context.read<ChatDatabase>(),
        chat: chat,
      ),
      child: Builder(
        builder: (context) {
          return TagSelectorScope(
            child: BlocListener<MessageManageCubit, MessageManageState>(
              listener: (context, state) {
                state.mapOrNull(
                  defaultMode: (defaultMode) {
                    _controller.text = '';
                    _isTagAddingOpened = false;

                    MessageInputScope.of(context).endEditMode();
                    TagSelectorScope.of(context).reset();
                  },
                  editMode: (editMode) {
                    _controller.text = editMode.message.text;
                    _isTagAddingOpened = editMode.message.tags.isNotEmpty;

                    MessageInputScope.of(context).startEditMode(
                      editMode.message,
                    );
                    TagSelectorScope.of(context).setSelected(
                      editMode.message.tags,
                    );
                  },
                );
              },
              child: BlocBuilder<MessageInputCubit, MessageInputState>(
                builder: (context, state) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                    ),
                    child: Column(
                      children: [
                        if (state.message.images.isNotEmpty)
                          const _SelectedImagesList(),
                        if (_isTagAddingOpened)
                          BlocListener<TagsCubit, TagsState>(
                            listener: (context, state) {
                              state.map(
                                initial: (initial) {
                                  MessageInputScope.of(context).setTags(
                                    IList([]),
                                  );
                                },
                                hasSelected: (hasSelected) {
                                  MessageInputScope.of(context).setTags(
                                    hasSelected.selected,
                                  );
                                },
                              );
                            },
                            child: const TagSelector(),
                          ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isTagAddingOpened = !_isTagAddingOpened;
                                });
                              },
                              icon: const Icon(
                                Icons.tag_outlined,
                              ),
                            ),
                            Expanded(
                              child: LimitedBox(
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    Insets.medium,
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      hintText: 'Message',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: MessageInputScope.of(context)
                                        .onTextChanged,
                                  ),
                                ),
                              ),
                            ),
                            _ChatInputMutableButton(
                              onSend: () {
                                MessageInputScope.of(context).send();
                                _controller.clear();
                                _isTagAddingOpened = false;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
