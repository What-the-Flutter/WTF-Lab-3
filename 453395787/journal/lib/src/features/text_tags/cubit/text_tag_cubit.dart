import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../api/text_tag_repository_api.dart';
import '../model/text_tag.dart';

part 'text_tag_state.dart';

part 'text_tag_cubit.freezed.dart';

class TextTagCubit extends Cubit<TextTagState> {
  TextTagCubit({
    required TextTagRepositoryApi textTagRepository,
  })  : _textTagRepository = textTagRepository,
        super(const TextTagState.initial());

  final TextTagRepositoryApi _textTagRepository;

  void onInputTextChanged(String text) {
    final tagText = _getLastTagText(text);
    if (tagText != null) {
      if (_textTagRepository.hasTagWithSameText(tagText)) {
        emit(
          TextTagState.success(
            tags: _textTagRepository.textTags.value
                .where(
                  (tag) => tag.text.contains(tagText),
                )
                .toIList(),
          ),
        );
      } else {
        emit(
          TextTagState.addModeState(
            tag: TextTag(
              id: '',
              text: tagText,
            ),
          ),
        );
      }
    } else {
      emit(
        const TextTagState.initial(),
      );
    }
  }

  String? _getLastTagText(String text) {
    final tagRegex = RegExp(r'(#[a-zA-Z0-9_]*)$');
    return tagRegex.firstMatch(text)?.group(0);
  }

  void onTagPressed(TextTag textTag) {
    emit(
      TextTagState.selectedState(tag: textTag),
    );
  }

  String autocompleteTagText({
    required String text,
    required String tagText,
  }) {
    final tagsAndWords = RegExp(r'(#[a-zA-Z0-9_]*)|([^#]+)').allMatches(text);

    final list = <String>[];
    for (var match in tagsAndWords) {
      for (var i = 0; i < match.groupCount; i++) {
        if (match.group(i) != null) {
          list.add(match.group(i)!);
          break;
        }
      }
    }

    var result = '';
    for (var word in list) {
      if (word.startsWith('#') && (word == tagText || tagText.contains(word))) {
        result += tagText;
      } else {
        result += word;
      }
    }
    return result;
  }
}
