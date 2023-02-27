import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/local/tag/tag_model.dart';
import '../../../domain/provider/tag/api_tag_provider.dart';
import '../../../domain/repository/tag/api_tag_repository.dart';
import '../../../util/typedefs.dart';

class TagRepository implements ApiTagRepository {
  TagRepository({
    required ApiTagProvider provider,
  }) : _provider = provider;

  final ApiTagProvider _provider;

  @override
  ValueStream<IList<TagModel>> get tagsStream => _provider.tags
      .transform(_provider.tagStreamTransform)
      .shareValueSeeded(IList());

  @override
  Future<FId> addTag(TagModel tag) async {
    return await _provider.addTag(
      _provider.firebaseTagModel(tag),
    );
  }

  @override
  Future<void> deleteTag(String id) async => await _provider.deleteTag(id);
}
