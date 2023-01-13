import 'package:drift/drift.dart';

import '../../../models/tag.dart';
import '../chat_database.dart';
import 'dao_api.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [TagTable])
class TagDao extends DatabaseAccessor<ChatDatabase>
    with _$TagDaoMixin, BaseDaoApi<TagTableData, TagTable> {
  TagDao(ChatDatabase db) : super(db);

  @override
  TableInfo<TagTable, TagTableData> get table => tagTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addTagModel(Tag tag) async {
    return add(
      TagTableCompanion.insert(
        content: tag.text,
        color: tag.color.value,
      ),
    );
  }
}
