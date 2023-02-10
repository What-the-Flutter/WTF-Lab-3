import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/strings.dart';
import '../../../data/interfaces/message_repository_interface.dart';
import '../../../domain/message_model.dart';

part 'message_input_state.dart';

part 'message_input_cubit.freezed.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required MessageRepositoryInterface repository,
  })  : _repository = repository,
        super(
          MessageInputState.defaultMode(
            message: MessageModel(),
            sendIcon: Icons.mic.codePoint,
            isTagOpened: false,
            tagSelected: IMap(),
          ),
        );

  final MessageRepositoryInterface _repository;

  int sendIcon = Icons.mic.codePoint;

  IList<MessageModel> get messages =>
      _repository.rxChatStreams.value.value.messages;

  void onChanged(String messageText) {
    messageText.isEmpty
        ? sendIcon = Icons.mic.codePoint
        : sendIcon = Icons.send.codePoint;

    emit(
      state.copyWith(
        message: state.message.copyWith(messageText: messageText),
      ),
    );
  }

  void updateTagVisible() {
    emit(
      state.copyWith(
        isTagOpened: !state.isTagOpened,
        tagSelected: IMap(),
      ),
    );
  }

  void updateTag(int index) {
    emit(
      state.copyWith(
        tagSelected: state.tagSelected.containsKey(index)
            ? state.tagSelected[index]!
                ? state.tagSelected.update(index, (value) => false)
                : state.tagSelected.update(index, (value) => true)
            : state.tagSelected.add(index, true),
      ),
    );
  }

  void putImages(List<String> images) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          images: state.message.images.addAll(images),
        ),
      ),
    );
  }

  void sendMessage(String messageText) {
    if (state.message.messageText.isNotEmpty ||
        state.message.images.isNotEmpty) {
      final tags = List<String>.empty(growable: true);

      if (state.tagSelected.isNotEmpty) {
        for (var key = 0; key < tagStrings.length; key++) {
          if (state.tagSelected.containsKey(key) && state.tagSelected[key]!) {
            tags.add(tagStrings[key]!);
          }
        }
      }

      _repository.add(
        MessageModel(
          id: messages.isEmpty ? 0 : messages.last.id + 1,
          messageText: messageText,
          images: state.message.images.isEmpty ? IList() : state.message.images,
          tags: tags.isEmpty ? IList([]) : tags.toIList(),
        ),
      );
      sendIcon = Icons.mic.codePoint;
      emit(
        state.copyWith(
          message: MessageModel(),
          sendIcon: sendIcon,
          tagSelected: IMap(),
          isTagOpened: false,
        ),
      );
    } else {}
  }
}
