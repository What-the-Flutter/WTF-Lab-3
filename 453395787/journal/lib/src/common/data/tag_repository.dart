import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/provider/tag_provider_api.dart';
import '../api/repository/tag_repository_api.dart';
import '../models/ui/tag.dart';
import '../utils/transformers.dart';
import '../utils/typedefs.dart';

class TagRepository extends TagRepositoryApi {
  TagRepository({
    required TagProviderApi tagProvider,
  }) : _provider = tagProvider;

  final TagProviderApi _provider;

  @override
  ValueStream<TagList> get tags => _provider.tags
      .transform(
        Transformers.modelsToTagsStreamTransformer,
      )
      .shareValueSeeded(
        Transformers.modelsToTags(
          _provider.tags.value,
        ),
      );

  @override
  Future<Id> addTag(Tag tag) async {
    return _provider.addTag(
      Transformers.tagToModel(tag),
    );
  }

  @override
  Future<void> updateTag(Tag tag) async {
    await _provider.updateTag(
      Transformers.tagToModel(tag),
    );
  }

  @override
  Future<void> deleteTag(Id tagId) async {
    await _provider.deleteTag(tagId);
  }
}
