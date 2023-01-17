import 'package:drift/drift.dart';

import '../chat_database.dart';
import 'base_dao.dart';

part 'image_to_message_dao.g.dart';

@DriftAccessor(tables: [
  ImageToMessageTable,
])
class ImageToMessageDao extends DatabaseAccessor<ChatDatabase>
    with
        _$ImageToMessageDaoMixin,
        BaseDao<ImageToMessageTableData, ImageToMessageTable> {
  ImageToMessageDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<ImageToMessageTable, ImageToMessageTableData> get table =>
      imageToMessageTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addRelation({
    required int messageId,
    required int imageId,
  }) async {
    return add(
      ImageToMessageTableCompanion.insert(
        messageId: messageId,
        imageId: imageId,
      ),
    );
  }
}
