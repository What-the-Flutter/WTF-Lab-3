import 'dart:async';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/api/provider/message_provider_api.dart';
import '../../../common/api/provider/storage_provider_api.dart';
import '../../../common/api/provider/tag_provider_api.dart';
import '../../../common/extensions/iterable_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/transformers.dart';
import '../../../common/utils/typedefs.dart';
import '../api/chat_messages_repository_api.dart';

class ChatMessagesRepository extends ChatMessagesRepositoryApi {
  ChatMessagesRepository({
    required MessageProviderApi messageProvider,
    required TagProviderApi tagProvider,
    required StorageProviderApi storageProvider,
    required Chat chat,
  })  : _messageProvider = messageProvider,
        _tagProvider = tagProvider,
        _storageProvider = storageProvider,
        _chat = chat {
    _providerMessageStream = messageProvider.messagesOf(
      chatId: chat.id,
    );

    _messageStreamController.add(
      _providerMessageStream.value,
    );

    _messageStreamSubscription = _providerMessageStream.listen(
      _messageStreamController.add,
    );
  }

  final MessageProviderApi _messageProvider;
  final TagProviderApi _tagProvider;
  final StorageProviderApi _storageProvider;

  final Chat _chat;

  static String _query = '';
  static IList<Tag>? _queryTags;

  late final ValueStream<DbMessageList> _providerMessageStream;

  final BehaviorSubject<DbMessageList> _messageStreamController =
      BehaviorSubject();

  late final StreamSubscription<DbMessageList> _messageStreamSubscription;

  void close() {
    _messageStreamSubscription.cancel();
  }

  @override
  ValueStream<MessageList> get messages => _transform(
        _filter(
          _messageStreamController.stream.shareValueSeeded(
            _messageStreamController.value,
          ),
        ),
      );

  ValueStream<MessageList> _transform(
    ValueStream<DbMessageList> messageStream,
  ) {
    final transformer = Transformers.modelsToMessagesStreamTransformer(
      fetchFile,
      getTag,
    );

    return messageStream.transform(transformer).shareValueSeeded(
          Transformers.modelsToMessages(
            messageStream.value,
            fetchFile,
            getTag,
          ),
        );
  }

  Tag getTag(String id) {
    final tagModel = _tagProvider.tags.value.firstWhere(
      (tag) => tag.id == id,
    );
    return Transformers.modelToTag(tagModel);
  }

  Future<File> fetchFile(String id) async {
    return _storageProvider.load(id);
  }

  ValueStream<DbMessageList> _filter(ValueStream<DbMessageList> messageStream) {
    return messageStream
        .transform(
          _filterTransformer,
        )
        .shareValueSeeded(
          _filterMessages(
            messageStream.value,
          ),
        );
  }

  final StreamTransformer<DbMessageList, DbMessageList> _filterTransformer =
      StreamTransformer.fromHandlers(
    handleData: (models, sink) {
      sink.add(
        _filterMessages(models),
      );
    },
  );

  static DbMessageList _filterMessages(DbMessageList messages) {
    return messages.where(
      (message) {
        if (_queryTags == null) {
          return message.text.containsIgnoreCase(_query);
        }
        return message.tagsId
                .containsAll(_queryTags!.map((e) => e.id).toIList()) &&
            message.text.containsIgnoreCase(_query);
      },
    ).toIList();
  }

  @override
  Chat get chat => _chat;

  @override
  ValueStream<TagList> get tags => _tagProvider.tags
      .transform(
        Transformers.modelsToTagsStreamTransformer,
      )
      .shareValueSeeded(
        Transformers.modelsToTags(
          _tagProvider.tags.value,
        ),
      );

  @override
  Future<void> add(Message message) async {
    await addToOtherChat(chat.id, message);
  }

  @override
  Future<void> addToOtherChat(String chatId, Message message) async {
    await _messageProvider.addMessage(
      chatId,
      await Transformers.messageToModel(
        message,
      ),
    );
  }

  @override
  Future<void> addToFavorites(Message message) async {
    await _messageProvider.updateMessage(
      await Transformers.messageToModel(
        message.copyWith(isFavorite: true),
      ),
    );
  }

  @override
  Future<void> remove(Message message) async {
    await _messageProvider.deleteMessage(message.id);
    for (var image in message.images) {
      _storageProvider.remove(
        basename(
          (await image).path,
        ),
      );
    }
  }

  @override
  Future<void> removeAll(MessageList messages) async {
    await _messageProvider.deleteMessages(
      messages.map((message) => message.id).toIList(),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    await _messageProvider.updateMessage(
      await Transformers.messageToModel(
        message.copyWith(isFavorite: false),
      ),
    );
  }

  @override
  Future<void> update(Message message) async {
    await _messageProvider.updateMessage(
      await Transformers.messageToModel(message),
    );
  }

  @override
  Future<void> search(String query, [TagList? tags]) async {
    ChatMessagesRepository._query = query;
    ChatMessagesRepository._queryTags = tags;
    _messageStreamController.add(
      _providerMessageStream.value,
    );
  }
}
