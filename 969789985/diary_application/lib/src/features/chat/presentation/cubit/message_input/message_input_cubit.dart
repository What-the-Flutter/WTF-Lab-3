import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/models/tag_model.dart';
import '../../../data/interfaces/message_repository_interface.dart';
import '../../../domain/message_model.dart';

part 'message_input_cubit.freezed.dart';
part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required MessageRepositoryInterface provider,
  })  : _provider = provider,
        super(
          MessageInputState.defaultMode(
            message: MessageModel(),
            canSend: false,
            isTagOpened: false,
            tagSelected: IMap(),
            tagRemoving: false,
          ),
        );

  final MessageRepositoryInterface _provider;

  IList<TagModel> get _tags => _provider.tags.value;

  void onChanged(String messageText) {
    emit(
      state.copyWith(
        message: state.message.copyWith(
          messageText: messageText,
          tags: state.tagSelected.isNotEmpty
              ? _tags
                  .where(
                    (tag) =>
                        state.tagSelected.containsKey(tag.id) &&
                        state.tagSelected[tag.id] == true,
                  )
                  .toIList()
              : IList(),
        ),
        canSend: messageText.isEmpty ? false : true,
      ),
    );
  }

  void updateSendPossibility() {
    emit(
      state.copyWith(
        canSend: !state.canSend,
      ),
    );
  }

  void updateTagVisible() {
    emit(
      state.copyWith(
        isTagOpened: !state.isTagOpened,
        tagSelected: IMap(),
        tagRemoving: false,
      ),
    );
  }

  void updateTagRemoving() {
    emit(
      state.copyWith(
        tagRemoving: !state.tagRemoving,
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
      _provider.addMessage(
        MessageModel(
          messageText: state.message.messageText,
          images: state.message.images,
          tags: state.message.tags,
        ),
      );
      emit(
        state.copyWith(
          message: MessageModel(),
          canSend: false,
          tagSelected: IMap(),
          isTagOpened: false,
        ),
      );
    } else {}
  }
}
