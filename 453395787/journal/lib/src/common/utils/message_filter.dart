import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/text_tags/model/text_tag.dart';
import '../extensions/iterable_extensions.dart';
import '../extensions/string_extensions.dart';
import '../models/ui/chat.dart';
import '../models/ui/message.dart';
import '../models/ui/tag.dart';
import 'typedefs.dart';

part 'message_filter.freezed.dart';

@freezed
class MessageFilter with _$MessageFilter {
  const MessageFilter._();

  const factory MessageFilter({
    @Default('') String query,
    @Default(IListConst([])) TagList tags,
    @Default(IListConst([])) TextTagList textTags,
    @Default(IListConst([])) ChatList chats,
    @Default(false) bool onlyFavorites,
  }) = _MessageFilter;

  MessageList applyTo(MessageList messages) {
    return messages
        .where(
          (message) =>
              _isFitByChat(message) &&
              _isFitByFavorite(message) &&
              _isFitByQuery(message) &&
              _isFitByTags(message) &&
              _isFitByTextTags(message),
        )
        .toIList();
  }

  bool _isFitByQuery(Message message) {
    return query.isEmpty ? true : message.text.containsIgnoreCase(query);
  }

  bool _isFitByTags(Message message) {
    if (tags.isEmpty) {
      return true;
    }

    return message.tags.containsAll(tags);
  }

  bool _isFitByTextTags(Message message) {
    final tagTexts = textTags.map((e) => e.text);
    for (var text in tagTexts) {
      if (!message.text.contains(text)) {
        return false;
      }
    }
    return true;
  }

  bool _isFitByFavorite(Message message) {
    return onlyFavorites ? message.isFavorite : true;
  }

  bool _isFitByChat(Message message) {
    if (chats.isEmpty) {
      return true;
    }

    final chatIds = chats.map((e) => e.id);
    return chatIds.contains(message.parentId);
  }
}
