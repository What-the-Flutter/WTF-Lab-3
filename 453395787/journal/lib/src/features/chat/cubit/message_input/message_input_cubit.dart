import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/message.dart';
import '../../../../common/models/tag.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/message_repository_api.dart';

part 'message_input_cubit.freezed.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(
          MessageInputState.defaultModeState(
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
    state.map(
      defaultModeState: (defaultModeState) {
        _repository.add(state.message);
      },
      editModeState: (editModeState) {
        _repository.update(state.message);
      },
    );
    emit(
      MessageInputState.defaultModeState(
        message: Message(),
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
        message: Message(),
      ),
    );
  }
}
