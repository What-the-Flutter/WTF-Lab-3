import 'package:drift/drift.dart';

import '../../models/tag_model.dart';
import '../chat_database.dart';
import '../tables/tags_table.dart';
import 'base_dao.dart';

part 'tags_dao.g.dart';

@DriftAccessor(tables: [TagsTable])
class TagsDao extends DatabaseAccessor<ChatDatabase>
    with _$TagsDaoMixin, BaseDao<TagsTableData, TagsTable> {
  TagsDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<TagsTable, TagsTableData> get table => tagsTable;

  @override
  DatabaseAccessor<GeneratedDatabase> get accessor => this;

  Future<int> addTag(TagModel tag) async {
    return add(
      TagsTableCompanion.insert(
        tagTitle: tag.tagTitle,
        tagIcon: tag.tagIcon,
      ),
    );
  }

  TagModel fromJson(TagsTableData tagsTableData) {
    return TagModel(
      id: tagsTableData.id,
      tagTitle: tagsTableData.tagTitle,
      tagIcon: tagsTableData.tagIcon,
    );
  }
}
