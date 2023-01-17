import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/message_provider_api.dart';
import '../../../common/models/tag.dart';
import '../../../common/utils/typedefs.dart';
import '../../theme/data/theme_repository.dart';

part 'manage_tags_state.dart';

part 'manage_tags_cubit.freezed.dart';

class ManageTagsCubit extends Cubit<ManageTagsState> {
  ManageTagsCubit({
    required MessageProviderApi messageProviderApi,
  })  : _messageProviderApi = messageProviderApi,
        super(
          ManageTagsState.initial(tags: messageProviderApi.tags.value),
        ) {
    _subscription = _messageProviderApi.tags.listen(
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
  late final StreamSubscription<TagList> _subscription;

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }

  void startAddingMode() {
    emit(
      ManageTagsState.addingMode(
        colors: ThemeRepository.colors.toIList(),
        newTag: const Tag(
          text: 'name',
          color: Colors.grey,
        ),
      ),
    );
  }

  void startEditingMode() {
    state.mapOrNull(
      selectionMode: (selectionMode) {
        emit(
          ManageTagsState.editingMode(
            colors: ThemeRepository.colors.toIList(),
            editableTag: selectionMode.tags.firstWhere(
              (e) => e.id == selectionMode.selectedTag,
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
      addingMode: (addingMode) {
        emit(
          addingMode.copyWith(
            newTag: addingMode.newTag.copyWith(
              text: text ?? addingMode.newTag.text,
              color: color ?? addingMode.newTag.color,
            ),
          ),
        );
      },
      editingMode: (editingMode) {
        emit(
          editingMode.copyWith(
            editableTag: editingMode.editableTag.copyWith(
              text: text ?? editingMode.editableTag.text,
              color: color ?? editingMode.editableTag.color,
            ),
          ),
        );
      },
    );
  }

  void applyChanges() {
    state.mapOrNull(
      addingMode: (addingMode) {
        _messageProviderApi.addTag(
          addingMode.newTag,
        );
      },
      editingMode: (editingMode) {
        _messageProviderApi.updateTag(
          editingMode.editableTag,
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
          ManageTagsState.selectionMode(
            tags: initial.tags,
            selectedTag: tag.id!,
          ),
        );
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selectedTag == tag.id) {
          emit(
            ManageTagsState.initial(
              tags: selectionMode.tags,
            ),
          );
        } else {
          emit(
            selectionMode.copyWith(
              selectedTag: tag.id!,
            ),
          );
        }
      },
    );
  }

  void remove() {
    state.mapOrNull(
      selectionMode: (selectionMode) {
        _messageProviderApi.deleteTag(
          selectionMode.selectedTag,
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
