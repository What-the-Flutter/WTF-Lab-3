import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../common/models/tag.dart';

abstract class Tags {
  static final IList<Tag> list = IList(
    [
      const Tag(text: 'done', color: Colors.green),
      const Tag(text: 'todo', color: Colors.grey),
      const Tag(text: 'important', color: Colors.orange),
      const Tag(text: 'warning', color: Colors.red),
      const Tag(text: 'music', color: Colors.blue),
      const Tag(text: 'work', color: Colors.purple),
      const Tag(text: 'hobby', color: Colors.tealAccent),
    ],
  );
}
