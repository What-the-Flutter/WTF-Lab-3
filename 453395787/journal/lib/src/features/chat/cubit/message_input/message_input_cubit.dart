import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/message.dart';
import '../../../../common/models/tag.dart';
import '../../api/message_repository_api.dart';

part 'message_input_cubit.freezed.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(
          MessageInputState.defaultMode(
            message: Message(),
          ),
        );

  final MessageRepositoryApi _repository;

  void onTextChanged(String text) {
    emit(
      state.copyWith(
        message: state.message.copyWith(text: text),
      ),
    );
  }

  void addImages(List<String> images) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          images: state.message.images.addAll(images.lock),
        ),
      ),
    );
  }

  void removeImage(String image) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          images: state.message.images.remove(image),
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

  void setTags(IList<Tag> tags) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          tags: tags,
        ),
      ),
    );
  }

  void send() {
    _repository.add(state.message);
    emit(
      MessageInputState.defaultMode(
        message: Message(),
      ),
    );
  }

  void startEditMode(Message message) {
    emit(
      MessageInputState.editMode(
        message: message,
      ),
    );
  }

  void endEditMode() {
    emit(
      MessageInputState.defaultMode(
        message: Message(),
      ),
    );
  }
}
