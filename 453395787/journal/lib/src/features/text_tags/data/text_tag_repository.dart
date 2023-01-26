import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../api/text_tag_firebase_provider_api.dart';
import '../api/text_tag_repository_api.dart';
import '../model/text_tag.dart';

class TextTagRepository implements TextTagRepositoryApi {
  const TextTagRepository({
    required TextTagFirebaseProviderApi textTagFirebaseProvider,
  }) : _provider = textTagFirebaseProvider;

  final TextTagFirebaseProviderApi _provider;

  @override
  ValueStream<IList<TextTag>> get textTags => _provider.textTags;

  @override
  Future<void> add(TextTag tag) => _provider.add(tag);

  @override
  Future<void> addFromText(String text) async {
    final tagRegex = RegExp(r'(#[a-zA-Z0-9_]+)');
    final tagTexts = tagRegex.allMatches(text).map(
          (match) => match.group(0)!,
        );
    if (tagTexts.isNotEmpty) {
      final providerTagTexts = _provider.textTags.value.map((tag) => tag.text);
      for (var text in tagTexts) {
        if (!providerTagTexts.contains(text)) {
          await _provider.add(
            TextTag(
              id: '',
              text: text,
            ),
          );
        }
      }
    }
  }

  @override
  bool hasTagWithSameText(String text) {
    final tagTexts = textTags.value.map((tag) => tag.text);
    for (var tagText in tagTexts) {
      if (tagText.contains(text)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> delete(TextTag tag) => _provider.delete(tag.id);
}
