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
import '../../../common/models/db/db_message.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/transformers.dart';
import '../../../common/utils/typedefs.dart';
import '../api/message_repository_api.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required MessageProviderApi messageProviderApi,
    required TagProviderApi tagProviderApi,
    required StorageProviderApi storageProvider,
    required Chat chat,
  })  : _messageProviderApi = messageProviderApi,
        _tagProviderApi = tagProviderApi,
        _storageProviderApi = storageProvider,
        _chat = chat {
    _providerMessageStream = messageProviderApi.messagesOf(
      chatId: chat.id,
    );

    _messageStreamController.add(
      _providerMessageStream.value,
    );

    _messageStreamSubscription = _providerMessageStream.listen(
      _messageStreamController.add,
    );
  }

  final MessageProviderApi _messageProviderApi;
  final TagProviderApi _tagProviderApi;
  final StorageProviderApi _storageProviderApi;

  final Chat _chat;

  static String _query = '';
  static IList<Tag>? _queryTags;

  late final ValueStream<IList<DbMessage>> _providerMessageStream;

  final BehaviorSubject<IList<DbMessage>> _messageStreamController =
      BehaviorSubject();

  late final StreamSubscription<IList<DbMessage>> _messageStreamSubscription;

  void close() {
    _messageStreamSubscription.cancel();
  }

  @override
  ValueStream<IList<Message>> get messages => _transform(
        _filter(
          _messageStreamController.stream.shareValueSeeded(
            _messageStreamController.value,
          ),
        ),
      );

  ValueStream<IList<Message>> _transform(
    ValueStream<IList<DbMessage>> messageStream,
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

  Tag getTag(Id id) {
    final tagModel = _tagProviderApi.tags.value.firstWhere(
      (tag) => tag.id == id,
    );
    return Transformers.modelToTag(tagModel);
  }

  Future<File> fetchFile(Id id) async {
    return _storageProviderApi.load(id);
  }

  ValueStream<IList<DbMessage>> _filter(
      ValueStream<IList<DbMessage>> messageStream) {
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

  final StreamTransformer<IList<DbMessage>, IList<DbMessage>>
      _filterTransformer = StreamTransformer.fromHandlers(
    handleData: (models, sink) {
      sink.add(
        _filterMessages(models),
      );
    },
  );

  static IList<DbMessage> _filterMessages(IList<DbMessage> messages) {
    return messages.where(
      (message) {
        if (_queryTags == null) {
          return message.text.containsIgnoreCase(_query);
        }
        return message.tagsId.containsAll(_queryTags!.map((e) => e.id).toIList()) &&
            message.text.containsIgnoreCase(_query);
      },
    ).toIList();
  }

  @override
  Chat get chat => _chat;

  @override
  ValueStream<IList<Tag>> get tags => _tagProviderApi.tags
      .transform(
        Transformers.modelsToTagsStreamTransformer,
      )
      .shareValueSeeded(
        Transformers.modelsToTags(
          _tagProviderApi.tags.value,
        ),
      );

  @override
  Future<void> add(Message message) async {
    await customAdd(chat.id, message);
  }

  @override
  Future<void> customAdd(Id chatId, Message message) async {
    await _messageProviderApi.addMessage(
      chatId,
      await Transformers.messageToModel(
        message,
      ),
    );
  }

  @override
  Future<void> addToFavorites(Message message) async {
    await _messageProviderApi.updateMessage(
      await Transformers.messageToModel(
        message.copyWith(isFavorite: true),
      ),
    );
  }

  @override
  Future<void> remove(Message message) async {
    await _messageProviderApi.deleteMessage(message.id);
    for (var image in message.images) {
      _storageProviderApi.remove(
        basename(
          (await image).path,
        ),
      );
    }
  }

  @override
  Future<void> removeAll(IList<Message> messages) async {
    await _messageProviderApi.deleteMessages(
      messages.map((message) => message.id).toIList(),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    await _messageProviderApi.updateMessage(
      await Transformers.messageToModel(
        message.copyWith(isFavorite: false),
      ),
    );
  }

  @override
  Future<void> update(Message message) async {
    await _messageProviderApi.updateMessage(
      await Transformers.messageToModel(message),
    );
  }

  @override
  Future<void> search(String query, [IList<Tag>? tags]) async {
    MessageRepository._query = query;
    MessageRepository._queryTags = tags;
    _messageStreamController.add(
      _providerMessageStream.value,
    );
  }
}
