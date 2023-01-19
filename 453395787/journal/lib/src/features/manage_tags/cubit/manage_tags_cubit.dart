import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/message_provider_api.dart';
import '../../../common/models/tag.dart';
import '../../../common/utils/colors.dart';
import '../../../common/utils/typedefs.dart';

part 'manage_tags_state.dart';

part 'manage_tags_cubit.freezed.dart';

class ManageTagsCubit extends Cubit<ManageTagsState> {
  ManageTagsCubit({
    required MessageProviderApi messageProviderApi,
  })
      : _messageProviderApi = messageProviderApi,
        super(
        ManageTagsState.initial(tags: messageProviderApi.tags.value),
      ) {
    _tagsStreamSubscription = _messageProviderApi.tags.listen(
          (event) {
        emit(
          ManageTagsState.initial(
            tags: event,
          ),
        );
      },
    );
  }

  final MessageProviderApi _messageProviderApi;
  late final StreamSubscription<TagList> _tagsStreamSubscription;

  @override
  Future<void> close() async {
    _tagsStreamSubscription.cancel();
    super.close();
  }

  void startAddingMode() {
    emit(
      ManageTagsState.addModeState(
        colors: AppColors.list,
        newTag: Tag(
          text: 'name',
          colorCode: Colors.grey.value,
        ),
      ),
    );
  }

  void startEditingMode() {
    state.mapOrNull(
      selectModeState: (selectModeState) {
        emit(
          ManageTagsState.editModeState(
            colors: AppColors.list,
            editableTag: selectModeState.tags.firstWhere(
                  (e) => e.id == selectModeState.selectedTag,
            ),
          ),
        );
      },
    );
  }

  void updateTag({
    String? text,
    Color? color,
  }) {
    state.mapOrNull(
      addModeState: (addModeState) {
        emit(
          addModeState.copyWith(
            newTag: addModeState.newTag.copyWith(
              text: text ?? addModeState.newTag.text,
              colorCode: color?.value ?? addModeState.newTag.colorCode,
            ),
          ),
        );
      },
      editModeState: (editModeState) {
        emit(
          editModeState.copyWith(
            editableTag: editModeState.editableTag.copyWith(
              text: text ?? editModeState.editableTag.text,
              colorCode: color?.value ?? editModeState.editableTag.colorCode,
            ),
          ),
        );
      },
    );
  }

  void applyChanges() {
    state.mapOrNull(
      addModeState: (addModeState) {
        _messageProviderApi.addTag(
          addModeState.newTag,
        );
      },
      editModeState: (editModeState) {
        _messageProviderApi.updateTag(
          editModeState.editableTag,
        );
      },
    );
    emit(
      ManageTagsState.initial(
        tags: _messageProviderApi.tags.value,
      ),
    );
  }

  void onTagPressed(Tag tag) {
    state.mapOrNull(
      initial: (initial) {
        emit(
          ManageTagsState.selectModeState(
            tags: initial.tags,
            selectedTag: tag.id,
          ),
        );
      },
      selectModeState: (selectModeState) {
        if (selectModeState.selectedTag == tag.id) {
          emit(
            ManageTagsState.initial(
              tags: selectModeState.tags,
            ),
          );
        } else {
          emit(
            selectModeState.copyWith(
              selectedTag: tag.id,
            ),
          );
        }
      },
    );
  }

  void remove() {
    state.mapOrNull(
      selectModeState: (selectModeState) {
        _messageProviderApi.deleteTag(
          selectModeState.selectedTag,
        );
        emit(
          ManageTagsState.initial(
            tags: _messageProviderApi.tags.value,
          ),
        );
      },
    );
  }

  void backToDefault() {
    emit(
      ManageTagsState.initial(
        tags: _messageProviderApi.tags.value,
      ),
    );
  }
}
