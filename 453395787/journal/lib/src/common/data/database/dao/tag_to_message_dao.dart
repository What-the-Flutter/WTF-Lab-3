import 'package:drift/drift.dart';

import '../chat_database.dart';
import 'base_dao.dart';

part 'tag_to_message_dao.g.dart';

@DriftAccessor(tables: [
  TagToMessageTable,
])
class TagToMessageDao extends DatabaseAccessor<ChatDatabase>
    with
        _$TagToMessageDaoMixin,
        BaseDao<TagToMessageTableData, TagToMessageTable> {
  TagToMessageDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<TagToMessageTable, TagToMessageTableData> get table =>
      tagToMessageTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addRelation({
    required int messageId,
    required int tagId,
  }) async {
    return add(
      TagToMessageTableCompanion.insert(
        messageId: messageId,
        tagId: tagId,
      ),
    );
  }
}
