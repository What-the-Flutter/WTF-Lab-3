import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../model/text_tag.dart';

abstract class TextTagRepositoryApi {
  ValueStream<IList<TextTag>> get textTags;

  Future<void> add(TextTag tag);

  Future<void> addFromText(String text);

  bool hasTagWithSameText(String text);

  Future<void> delete(TextTag tag);
}
