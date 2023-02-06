import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/repository/tag_repository_api.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/colors.dart';
import '../../../common/utils/typedefs.dart';

part 'manage_tags_state.dart';

part 'manage_tags_cubit.freezed.dart';

class ManageTagsCubit extends Cubit<ManageTagsState> {
  ManageTagsCubit({
    required TagRepositoryApi tagRepository,
  })  : _repository = tagRepository,
        super(
          ManageTagsState.initial(tags: tagRepository.tags.value),
        ) {
    _tagsStreamSubscription = _repository.tags.listen(
      (event) {
        emit(
          ManageTagsState.initial(
            tags: event,
          ),
        );
      },
    );
  }

  final TagRepositoryApi _repository;
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
        newTag: const Tag(
          text: 'name',
          color: Colors.grey,
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
              color: color ?? addModeState.newTag.color,
            ),
          ),
        );
      },
      editModeState: (editModeState) {
        emit(
          editModeState.copyWith(
            editableTag: editModeState.editableTag.copyWith(
              text: text ?? editModeState.editableTag.text,
              color: color ?? editModeState.editableTag.color,
            ),
          ),
        );
      },
    );
  }

  void applyChanges() {
    state.mapOrNull(
      addModeState: (addModeState) {
        _repository.addTag(
          addModeState.newTag,
        );
      },
      editModeState: (editModeState) {
        _repository.updateTag(
          editModeState.editableTag,
        );
      },
    );
    emit(
      ManageTagsState.initial(
        tags: _repository.tags.value,
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
        _repository.deleteTag(
          selectModeState.selectedTag,
        );
        emit(
          ManageTagsState.initial(
            tags: _repository.tags.value,
          ),
        );
      },
    );
  }

  void backToDefault() {
    emit(
      ManageTagsState.initial(
        tags: _repository.tags.value,
      ),
    );
  }
}
