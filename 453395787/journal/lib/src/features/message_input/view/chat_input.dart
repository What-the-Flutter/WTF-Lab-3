import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/message_repository.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/radius.dart';
import '../../messages_manage/cubit/message_manage_cubit.dart';
import '../cubit/message_input_cubit.dart';

part '../widget/input_mutable_button.dart';
part '../widget/selected_images.dart';
part '../widget/selected_tag.dart';

class ChatInput extends StatelessWidget {
  ChatInput({
    super.key,
    required this.chatId,
  });

  final int chatId;

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageInputCubit(
        repository: MessageRepository(
          chatRepository: context.read<ChatRepository>(),
          chatIndex: chatId,
        ),
      ),
      child: Builder(builder: (context) {
        return BlocListener<MessageManageCubit, MessageManageState>(
          listener: (context, state) {
            state.maybeMap(
              defaultMode: (defaultMode) {
                _inputController.text = '';
                context.read<MessageInputCubit>().endEditMode();
              },
              editMode: (editMode) {
                _inputController.text = editMode.message.text;
                context
                    .read<MessageInputCubit>()
                    .startEditMode(editMode.message);
              },
              orElse: () {},
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
                    if (state.message.tags.isNotEmpty) const _SelectedTagList(),
                    Row(
                      children: [
                        const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.add),
                        ),
                        Expanded(
                          child: LimitedBox(
                            maxHeight: MediaQuery.of(context).size.width * 0.2,
                            child: Padding(
                              padding: const EdgeInsets.all(Insets.medium),
                              child: TextFormField(
                                controller: _inputController,
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
                                onChanged: context
                                    .read<MessageInputCubit>()
                                    .onTextChanged,
                              ),
                            ),
                          ),
                        ),
                        _ChatInputMutableButton(
                          onPressed: () {
                            context.read<MessageInputCubit>().send();
                            _inputController.clear();
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
      }),
    );
  }
}
