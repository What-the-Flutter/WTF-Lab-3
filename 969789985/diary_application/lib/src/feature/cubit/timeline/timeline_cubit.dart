import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/domain/models/local/message/message_model.dart';
import '../../../core/domain/models/local/tag/tag_model.dart';
import '../../../core/domain/repository/chat/api_chat_repository.dart';
import '../../../core/domain/repository/message/api_message_repository.dart';
import '../../../core/domain/repository/tag/api_tag_repository.dart';
import '../../../core/util/logger.dart';
import '../../../core/util/resources/strings.dart';

part 'timeline_state.dart';

part 'timeline_cubit.freezed.dart';

class TimelineCubit extends Cubit<TimelineState> {
  final ApiMessageRepository _messageRepository;
  final ApiChatRepository _chatRepository;
  final ApiTagRepository _tagRepository;
  late final StreamSubscription<IList<MessageModel>> _messageSubscription;
  late final StreamSubscription<IList<ChatModel>> _chatSubscription;
  late final StreamSubscription<IList<TagModel>> _tagSubscription;
  late IList<MessageModel> _messages;

  TimelineCubit({
    required ApiMessageRepository messageRepository,
    required ApiChatRepository chatRepository,
    required ApiTagRepository tagRepository,
  })  : _messageRepository = messageRepository,
        _chatRepository = chatRepository,
        _tagRepository = tagRepository,
        super(
        TimelineState.defaultMode(
          messages: IList<MessageModel>(),
          defaultMessages: IList<MessageModel>(),
          chats: IList<ChatModel>(),
          tags: tagRepository.tagsStream.value,
          isFiltered: false,
        ),
      ) {
    _messageSubscription = _messageRepository.messagesStreamForTimeline.listen(
          (messages) {
        emit(
          state.copyWith(
            messages: messages,
            defaultMessages: messages,
          ),
        );
        _messages = messages;
      },
    );

    _chatSubscription = _chatRepository.chats.listen(
          (chats) {
        emit(
          state.copyWith(
            chats: chats,
          ),
        );
      },
    );

    _tagSubscription = _tagRepository.tagsStream.listen(
          (tags) {
        emit(
          state.copyWith(
            tags: tags,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _messageSubscription.cancel();
    _chatSubscription.cancel();
    _tagSubscription.cancel();

    return super.close();
  }

  Future<void> deleteMessage(MessageModel message) async =>
      await _messageRepository.deleteMessage(message);

  Future<void> deleteSelectedMessages(IList<MessageModel> messages) async =>
      messages.map(deleteMessage);

  void clearFilters() {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        emit(
          defaultMode.copyWith(
            isFiltered: false,
            messages: _messages,
          ),
        );
      },
    );
  }

  void updateModeForStatistic() {
    state.mapOrNull(defaultMode: (defaultMode) {
      emit(
        TimelineState.filterMode(
          messages: defaultMode.messages,
          defaultMessages: _messages,
          chats: defaultMode.chats,
          tags: defaultMode.tags,
          filterWay: 0,
          searchQuery: '',
          tagIds: ISet<String>(),
          chatIds: ISet<String>(),
          dateFilter: DateFilter.newOnce.dateFilter,
          imagesOnly: false,
          audioOnly: false,
          strongTagFilter: false,
          resultExist: true,
        ),
      );
    });
  }

  void updateMode(bool withFilter) {
    state.map(
      defaultMode: (defaultMode) {
        emit(
          TimelineState.filterMode(
            messages: defaultMode.messages,
            defaultMessages: _messages,
            chats: defaultMode.chats,
            tags: defaultMode.tags,
            filterWay: 0,
            searchQuery: '',
            tagIds: ISet<String>(),
            chatIds: ISet<String>(),
            dateFilter: DateFilter.newOnce.dateFilter,
            imagesOnly: false,
            audioOnly: false,
            strongTagFilter: false,
            resultExist: true,
          ),
        );
      },
      filterMode: (filterMode) {
        emit(
          TimelineState.defaultMode(
            messages: withFilter ? filterMode.messages : _messages,
            defaultMessages: _messages,
            chats: filterMode.chats,
            tags: filterMode.tags,
            isFiltered: !listEquals(
              _messages.toList(),
              filterMode.messages.toList(),
            ),
          ),
        );
      },
    );
  }

  void onSearchQueryChanged(String query) {
    state.mapOrNull(
      filterMode: (filterMode) {
        final messages = _messagesWithTags()
            .where(
              (message) => message.messageText.toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
            .toIList();

        emit(
          filterMode.copyWith(
            searchQuery: query,
            messages: query.isEmpty ? _messagesWithTags() : messages,
            resultExist: messages.isEmpty ? true : false,
          ),
        );
      },
    );
  }

  set filterWay(int filterWay) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            filterWay: filterWay,
          ),
        );
      },
    );
  }

  set strongTagFilter(bool value) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            strongTagFilter: value,
          ),
        );
      },
    );
  }

  void clearTagFilters() {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(tagIds: ISet<String>(), messages: _messages),
        );
      },
    );
  }

  void updateSelectableTags(String tagId) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            tagIds: filterMode.tagIds.contains(tagId)
                ? filterMode.tagIds.remove(tagId)
                : filterMode.tagIds.add(tagId),
          ),
        );
      },
    );

    state.mapOrNull(
      filterMode: (filterMode) {
        final messages = _messagesWithTags();

        emit(
          filterMode.copyWith(messages: messages),
        );
      },
    );
  }

  IList<MessageModel> _messagesWithTags() {
    return state.mapOrNull(
      filterMode: (filterMode) {
        final tagsLists = filterMode.tagIds.map(
              (id) => filterMode.tags.where(
                (tag) => tag.id == id,
          ),
        );

        final tags = tagsLists.expand((list) => list).toList();

        logger('Selected tags: $tags', 'Timeline_filter');

        final messagesOfChats = messagesOfSelectedChats();
        if (filterMode.tagIds.isEmpty) return messagesOfChats;

        if (filterMode.strongTagFilter) {
          Function deepEq = const DeepCollectionEquality.unordered().equals;

          final messages = messagesOfChats
              .where(
                (mes) => deepEq(
              tags,
              mes.tags.toList(),
            ),
          )
              .toIList();

          logger('Messages is (strong) $messages', 'Timeline_filter');

          return messages;
        } else {
          final messagesExLists = messagesOfChats.map(
                (mes) => mes.tags.map(
                  (tag) => tags.map(
                    (e) {
                  if (e.id == tag.id) {
                    return mes;
                  }
                },
              ).toISet(),
            ),
          );

          final messagesLists = messagesExLists.expand((list) => list);

          final messagesEx = messagesLists.expand((list) => list).toIList();

          final messages = messagesEx
              .where((mes) => mes != null)
              .toISet()
              .removeWhere((mes) => mes == null);

          logger('Messages is (non-strong): $messages', 'Timeline_filter');

          return messages.map((mes) => mes!).toIList();
        }
      },
    )!;
  }

  void updateSelectableChats(String chatId) {
    logger('$chatId', 'Selection chat');

    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            chatIds: filterMode.chatIds.contains(chatId)
                ? filterMode.chatIds.remove(chatId)
                : filterMode.chatIds.add(chatId),
            tagIds: ISet<String>(),
          ),
        );
      },
    );

    state.mapOrNull(
      filterMode: (filterMode) {
        final messages = messagesOfSelectedChats();

        emit(
          filterMode.copyWith(messages: messages),
        );
      },
    );
  }

  IList<ChatModel> selectedChats() {
    Iterable<Iterable<ChatModel>> chats = [];

    state.mapOrNull(
      filterMode: (filterMode) {
        chats = filterMode.chatIds.map(
              (id) => filterMode.chats.where((chat) => chat.id == id),
        );
      },
    );

    return chats.expand((list) => list).toIList();
  }

  IList<MessageModel> messagesOfSelectedChats() {
    return state.mapOrNull(
      filterMode: (filterMode) {
        final messagesLists = filterMode.chatIds.map(
              (id) => _messages.where(
                (mes) => mes.parentId == id,
          ),
        );

        final messages = messagesLists.expand((list) => list).toIList();

        return messages.isEmpty ? _messages : messages;
      },
    )!;
  }

  set dateFilter(DateFilter filter) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            dateFilter: filter.dateFilter,
            messages: filter == DateFilter.newOnce
                ? filterMode.messages.sort(
                  (a, b) => a.sendDate.compareTo(b.sendDate),
            )
                : filterMode.messages.sort(
                  (a, b) => b.sendDate.compareTo(a.sendDate),
            ),
          ),
        );
      },
    );
  }

  set imagesOnly(bool value) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            imagesOnly: value,
            messages: value
                ? filterMode.messages
                .where((mes) => mes.images.isNotEmpty)
                .toIList()
                : _messages,
          ),
        );
      },
    );
  }

  set audioOnly(bool value) {
    state.mapOrNull(
      filterMode: (filterMode) {
        emit(
          filterMode.copyWith(
            audioOnly: value,
          ),
        );
      },
    );
  }

  int countFiles() {
    final files = state.defaultMessages.map((mes) => mes.images);

    return files.expand((list) => list).length;
  }
}
