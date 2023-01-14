import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../models/tag.dart';
import '../chat_database.dart';
import 'dao_api.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [TagTable])
class TagDao extends DatabaseAccessor<ChatDatabase>
    with _$TagDaoMixin, BaseDaoApi<TagTableData, TagTable> {
  TagDao(ChatDatabase db) : super(db) {
    init();
  }

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

  Tag transformToModel(TagTableData tagTableData) {
    return Tag(
      id: tagTableData.uid,
      text: tagTableData.content,
      color: Color(
        tagTableData.color,
      ),
    );
  }
}
