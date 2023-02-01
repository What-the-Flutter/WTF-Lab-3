import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../api/provider/message_provider_api.dart';
import '../../api/provider/storage_provider_api.dart';
import '../../api/provider/tag_provider_api.dart';
import '../../api/repository/message_overview_repository_api.dart';
import '../../models/ui/tag.dart';
import '../../utils/app_logger.dart';
import '../../utils/message_filter.dart';
import '../../utils/transformers.dart';
import '../../utils/typedefs.dart';

class MessageOverviewRepository
    with AppLogger
    implements MessageOverviewRepositoryApi {
  MessageOverviewRepository({
    required MessageProviderApi messageProvider,
    required TagProviderApi tagProviderApi,
    required StorageProviderApi storageProvider,
  })  : _messageProvider = messageProvider,
        _tagProvider = tagProviderApi,
        _storageProvider = storageProvider {
    _providerMessageStream = messageProvider.messages;

    _messageStreamController.add(
      _providerMessageStream.value,
    );

    _providerMessageStreamSubscription = _providerMessageStream.listen(
      _messageStreamController.add,
    );
  }

  final MessageProviderApi _messageProvider;
  final TagProviderApi _tagProvider;
  final StorageProviderApi _storageProvider;

  late final ValueStream<DbMessageList> _providerMessageStream;

  final BehaviorSubject<DbMessageList> _messageStreamController =
      BehaviorSubject();

  late final StreamSubscription<DbMessageList>
      _providerMessageStreamSubscription;

  static MessageFilter _filter = const MessageFilter();

  @override
  ValueStream<MessageList> get messages => _messageFilter(
        _transformModelsToMessages(
          _messageStreamController.stream.shareValueSeeded(
            _messageStreamController.value,
          ),
        ),
      );

  ValueStream<MessageList> _transformModelsToMessages(
    ValueStream<DbMessageList> messageStream,
  ) {
    final transformer = Transformers.modelsToMessagesStreamTransformer(
      _storageProvider.load,
      _tagById,
    );

    return messageStream.transform(transformer).shareValueSeeded(
          Transformers.modelsToMessages(
            messageStream.value,
            _storageProvider.load,
            _tagById,
          ),
        );
  }

  ValueStream<MessageList> _messageFilter(
      ValueStream<MessageList> messageStream) {
    return messageStream
        .transform(
          _filterTransformer,
        )
        .shareValueSeeded(
          _filter.applyTo(
            messageStream.value,
          ),
        );
  }

  final StreamTransformer<MessageList, MessageList> _filterTransformer =
      StreamTransformer.fromHandlers(
    handleData: (models, sink) {
      sink.add(
        _filter.applyTo(models),
      );
    },
  );

  Tag _tagById(String id) {
    final tagModel = _tagProvider.tags.value.firstWhere(
      (tag) => tag.id == id,
    );
    return Transformers.modelToTag(tagModel);
  }

  @override
  void filter(MessageFilter filter) {
    _filter = filter;
    _messageStreamController.add(
      _providerMessageStream.value,
    );
  }

  void close() {
    _providerMessageStreamSubscription.cancel();
  }
}
