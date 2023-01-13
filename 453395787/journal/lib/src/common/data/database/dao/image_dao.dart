import 'package:drift/drift.dart';

import '../chat_database.dart';
import 'dao_api.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [ImageTable])
class ImageDao extends DatabaseAccessor<ChatDatabase>
    with _$ImageDaoMixin, BaseDaoApi<ImageTableData, ImageTable> {
  ImageDao(ChatDatabase db) : super(db);

  @override
  TableInfo<ImageTable, ImageTableData> get table => imageTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addImageModel(String image) async {
    return add(
      ImageTableCompanion.insert(
        path: image,
      ),
    );
  }
}
