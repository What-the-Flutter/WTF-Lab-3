import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../model/text_tag.dart';

abstract class TextTagProviderApi {
  ValueStream<IList<TextTag>> get textTags;

  Future<void> add(TextTag tag);

  Future<void> delete(String id);
}
