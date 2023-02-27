import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../domain/models/local/tag/tag_model.dart';
import '../../../util/typedefs.dart';

mixin TagConverter {
  IList<FId> toFirebaseTagModel(IList<TagModel> tags) => tags
      .map(
        (el) => el.id,
      )
      .toIList();

  IList<TagModel> fromFirebaseTagModel(IList<FId> firebaseTags) => firebaseTags
      .map(
        (e) => TagModel(
          id: e,
        ),
      )
      .toIList();
}
