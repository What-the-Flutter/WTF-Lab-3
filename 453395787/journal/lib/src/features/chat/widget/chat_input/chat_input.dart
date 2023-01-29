import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

import '../../../../common/data/provider/message_firebase_provider.dart';
import '../../../../common/data/provider/storage_firebase_provider.dart';
import '../../../../common/data/provider/tag_firebase_provider.dart';
import '../../../../common/data/repository/chat_repository.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/utils/insets.dart';
import '../../../../common/utils/locale.dart' as locale;
import '../../../../common/utils/radius.dart';
import '../../../text_tags/text_tags.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../../cubit/tag_selector/tags_cubit.dart';
import '../../data/chat_messages_repository.dart';
import '../scopes/message_input_scope.dart';
import '../scopes/tags_scope.dart';
import '../tag_selector/tag_selector.dart';

part 'input_mutable_button.dart';

part 'selected_images.dart';

part 'message_manage_bloc_listener.dart';

part 'text_tag_bloc_listener.dart';

part 'chat_input_scopes_and_listeners.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.chatId,
  });

  final String chatId;

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
    return _ChatInputScopesAndListeners(
      chatId: widget.chatId,
      inputTextController: _controller,
      onDefaultModeStarted: () {
        _controller.text = '';
        _isTagAddingOpened = false;
      },
      onEditModeStarted: (message) {
        _controller.text = message.text;
        _isTagAddingOpened = message.tags.isNotEmpty;
      },
      child: BlocBuilder<MessageInputCubit, MessageInputState>(
        builder: (context, state) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
            ),
            child: Column(
              children: [
                const TextTagSelector(),
                if (state.message.images.isNotEmpty)
                  const _SelectedImagesList(),
                if (_isTagAddingOpened)
                  BlocListener<TagsCubit, TagsState>(
                    listener: (context, state) {
                      state.map(
                        initial: (_) {
                          MessageInputScope.of(context).setTags(
                            IList([]),
                          );
                        },
                        hasSelectedState: (hasSelectedState) {
                          MessageInputScope.of(context).setTags(
                            hasSelectedState.tags
                                .where(
                                  (tag) =>
                                      hasSelectedState.selected.contains(tag),
                                )
                                .toIList(),
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
                        maxHeight: MediaQuery.of(context).size.width * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            Insets.medium,
                          ),
                          child: TextFormField(
                            controller: _controller,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              hintText: locale.Hints.inputMessage.i18n(),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (text) {
                              MessageInputScope.of(context).onTextChanged(text);
                              context
                                  .read<TextTagCubit>()
                                  .onInputTextChanged(text);
                            },
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
    );
  }
}
