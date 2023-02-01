import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/provider/storage_provider_api.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/models/ui/tag.dart';
import '../../../../common/utils/typedefs.dart';
import '../../../text_tags/text_tags.dart';
import '../../api/chat_messages_repository_api.dart';

part 'message_input_cubit.freezed.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required ChatMessagesRepositoryApi chatMessagesRepository,
    required StorageProviderApi storageProvider,
    required TextTagRepositoryApi textTagRepository,
  })  : _chatMessagesRepository = chatMessagesRepository,
        _storage = storageProvider,
        _textTagRepository = textTagRepository,
        super(
          MessageInputState.defaultModeState(
            message: Message(
              parentId: '',
              dateTime: DateTime.now(),
            ),
          ),
        );

  final ChatMessagesRepositoryApi _chatMessagesRepository;
  final StorageProviderApi _storage;
  final TextTagRepositoryApi _textTagRepository;

  void onTextChanged(String text) {
    emit(
      state.copyWith(
        message: state.message.copyWith(text: text),
      ),
    );
  }

  Future<void> addImages(IList<File> images) async {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          images: state.message.images.addAll(
            images.map(
              Future.value,
            ),
          ),
        ),
      ),
    );
  }

  void removeImage(Future<File> image) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          images: state.message.images.removeWhere(
            (e) => e == image,
          ),
        ),
      ),
    );
  }

  void addTag(Tag tag) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          tags: state.message.tags.add(tag),
        ),
      ),
    );
  }

  void removeTag(Tag tag) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          tags: state.message.tags.remove(tag),
        ),
      ),
    );
  }

  void setTags(TagList tags) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          tags: tags,
        ),
      ),
    );
  }

  void send() {
    for (var image in state.message.images) {
      image.then(_storage.save);
    }

    state.map(
      defaultModeState: (defaultModeState) {
        _chatMessagesRepository.add(state.message);
        _textTagRepository.addFromText(state.message.text);
      },
      editModeState: (editModeState) {
        _chatMessagesRepository.update(state.message);
        _textTagRepository.addFromText(state.message.text);
      },
    );
    emit(
      MessageInputState.defaultModeState(
        message: Message(
          parentId: '',
          dateTime: DateTime.now(),
        ),
      ),
    );
  }

  void startEditMode(Message message) {
    emit(
      MessageInputState.editModeState(
        message: message,
      ),
    );
  }

  void endEditMode() {
    emit(
      MessageInputState.defaultModeState(
        message: Message(
          parentId: '',
          dateTime: DateTime.now(),
        ),
      ),
    );
  }
}
