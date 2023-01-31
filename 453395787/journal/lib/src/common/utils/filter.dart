import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/text_tags/model/text_tag.dart';
import '../extensions/iterable_extensions.dart';
import '../extensions/string_extensions.dart';
import '../models/ui/chat.dart';
import '../models/ui/message.dart';
import '../models/ui/tag.dart';
import 'typedefs.dart';

part 'filter.freezed.dart';

@freezed
class Filter with _$Filter {
  const Filter._();

  const factory Filter({
    @Default('') String query,
    @Default(IListConst([])) TagList tags,
    @Default(IListConst([])) TextTagList textTags,
    @Default(IListConst([])) ChatList chats,
    @Default(false) bool onlyFavorites,
  }) = _Filter;

  MessageList apply(MessageList messages) {
    return messages
        .where(
          (message) =>
              isFitsByChat(message) &&
              isFitsByFavorite(message) &&
              isFitsByQuery(message) &&
              isFitsByTags(message) &&
              isFitsByTextTags(message),
        )
        .toIList();
  }

  bool isFitsByQuery(Message message) {
    return query.isEmpty ? true : message.text.containsIgnoreCase(query);
  }

  bool isFitsByTags(Message message) {
    if (tags.isEmpty) {
      return true;
    }

    return message.tags.containsAll(tags);
  }

  bool isFitsByTextTags(Message message) {
    final tagTexts = textTags.map((e) => e.text);
    for (var text in tagTexts) {
      if (!message.text.contains(text)) {
        return false;
      }
    }
    return true;
  }

  bool isFitsByFavorite(Message message) {
    return onlyFavorites ? message.isFavorite : true;
  }

  bool isFitsByChat(Message message) {
    if (chats.isEmpty) {
      return true;
    }

    final chatIds = chats.map((e) => e.id);
    return chatIds.contains(message.parentId);
  }
}
