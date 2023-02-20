import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/api/message/api_message_repository.dart';
import '../../../../core/domain/api/storage/api_storage_repository.dart';
import '../../../../core/domain/api/tag/api_tag_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../core/util/typedefs.dart';

part 'message_input_cubit.freezed.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit({
    required ApiMessageRepository repository,
    required ApiTagRepository tagRepository,
    required ApiStorageRepository storageRepository,
  })  : _repository = repository,
        _tagRepository = tagRepository,
        _storageRepository = storageRepository,
        super(
          MessageInputState.defaultMode(
            message: MessageModel(),
            tags: IList(),
            canSend: false,
          ),
        ) {
    _tagSubscription = _tagRepository.tagsStream.listen(
      (tags) {
        emit(
          MessageInputState.defaultMode(
            message: MessageModel(),
            tags: tags,
            canSend: false,
          ),
        );
      },
    );
  }

  final ApiMessageRepository _repository;
  final ApiTagRepository _tagRepository;
  final ApiStorageRepository _storageRepository;

  late final StreamSubscription<IList<TagModel>> _tagSubscription;

  @override
  Future<void> close() {
    _tagSubscription.cancel();

    return super.close();
  }

  void onChanged(String messageText) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        emit(
          defaultMode.copyWith(
            message: defaultMode.message.copyWith(
              messageText: messageText,
            ),
            canSend: messageText.isEmpty ? false : true,
          ),
        );
      },
      tagMode: (tagMode) {
        emit(
          tagMode.copyWith(
            message: tagMode.message.copyWith(
              messageText: messageText,
            ),
          ),
        );
      },
    );
  }

  void updateTagVisible() {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        emit(
          MessageInputState.tagMode(
            message: defaultMode.message,
            selectedTags: IMap<String, bool>(),
            removingMode: false,
            tags: defaultMode.tags,
          ),
        );
      },
      tagMode: (tagMode) {
        emit(
          MessageInputState.defaultMode(
            message: tagMode.message,
            tags: tagMode.tags,
            canSend: tagMode.message.messageText.isEmpty ? false : true,
          ),
        );
      },
    );
  }

  void updateTagRemoving() {
    state.mapOrNull(
      tagMode: (tagMode) {
        emit(
          tagMode.copyWith(
            removingMode: !tagMode.removingMode,
          ),
        );
      },
    );
  }

  void updateTag(String index) {
    state.mapOrNull(
      tagMode: (tagMode) {
        emit(
          tagMode.copyWith(
            selectedTags: tagMode.selectedTags.containsKey(index)
                ? tagMode.selectedTags[index]!
                    ? tagMode.selectedTags.update(index, (value) => false)
                    : tagMode.selectedTags.update(index, (value) => true)
                : tagMode.selectedTags.add(index, true),
          ),
        );
      },
    );

    state.mapOrNull(
      tagMode: (tagMode) {
        emit(
          tagMode.copyWith(
            message: state.message.copyWith(
              tags: tagMode.tags
                  .where(
                    (tag) => tagMode.selectedTags[tag.id] == true,
                  )
                  .toIList(),
            ),
          ),
        );
      },
    );
  }

  void putImages(List<String> images) {
    state.mapOrNull(
      defaultMode: (defaultMode) async {
        emit(
          defaultMode.copyWith(
            message: defaultMode.message.copyWith(
              images: images.map(await _storageRepository.loadImage).toIList(),
            ),
            canSend: images.isEmpty ? false : true,
          ),
        );
      },
    );

    for (final path in images) {
      _storageRepository.saveImage(
        File(path),
      );
    }
  }

  void sendMessage(
    String messageText,
  ) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        _sendAction(
          defaultMode.message.messageText,
          defaultMode.message.images,
          defaultMode.message.tags,
        );
      },
      tagMode: (tagMode) {
        _sendAction(
          tagMode.message.messageText,
          tagMode.message.images,
          tagMode.message.tags,
        );
      },
    );
  }

  void _sendAction(
    String messageText,
    IList<Future<File>> imagePaths,
    IList<TagModel> tags,
  ) {
    if (messageText.isNotEmpty || imagePaths.isNotEmpty) {
      _repository.addMessage(
        MessageModel(
          messageText: messageText,
          images: imagePaths,
          tags: tags,
        ),
      );
      emit(
        MessageInputState.defaultMode(
          message: MessageModel(),
          tags: state.tags,
          canSend: false,
        ),
      );
    } else {}
  }

  void deleteTag(FId tagId) {
    _tagRepository.deleteTag(tagId);
  }
}
