import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/message_filter.dart';
import '../../text_tags/model/text_tag.dart';

part 'message_filter_state.dart';

part 'message_filter_cubit.freezed.dart';

class MessageFilterCubit extends Cubit<MessageFilterState> {
  MessageFilterCubit({
    required IList<Tag> tags,
    required IList<TextTag> textTags,
    required IList<Chat> chats,
  }) : super(
          MessageFilterState(
            tags: tags,
            textTags: textTags,
            chats: chats,
          ),
        );

  void setSelectedTags(IList<Tag> tags) {
    emit(
      state.copyWith(
        selectedTags: tags,
      ),
    );
    _filter = _filter.copyWith(tags: tags);
  }

  void setSelectedTextTags(IList<TextTag> tags) {
    emit(
      state.copyWith(
        selectedTextTags: tags,
      ),
    );
    _filter = _filter.copyWith(textTags: tags);
  }

  void setSelectedChats(IList<Chat> chats) {
    emit(
      state.copyWith(
        selectedChats: chats,
      ),
    );
    _filter = _filter.copyWith(chats: chats);
  }

  void reset() {
    emit(
      state.copyWith(
        selectedTags: IList([]),
        selectedTextTags: IList([]),
        selectedChats: IList([]),
      ),
    );
    _filter = _filter.copyWith(
      tags: IList([]),
      textTags: IList([]),
      chats: IList([]),
    );
  }

  MessageFilter _filter = const MessageFilter();

  MessageFilter get filter => _filter;
}
