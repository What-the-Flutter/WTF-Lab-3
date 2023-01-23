import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/provider/message_provider_api.dart';
import '../../extensions/snapshot_extension.dart';
import '../../models/db/db_message.dart';
import '../../utils/app_logger.dart';
import '../../utils/typedefs.dart';
import 'base_provider.dart';

class MessageProvider extends BaseProvider
    with AppLogger
    implements MessageProviderApi {
  final Id _userId;

  @override
  Id get userId => _userId;

  MessageProvider({required Id userId}) : _userId = userId;

  @override
  Future<Id> addMessage(Id chatId, DbMessage message) async {
    final ref = messagesRef.push();
    await ref.set(
      message
          .copyWith(
            id: ref.key!,
            parentId: chatId,
          )
          .toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateMessage(DbMessage message) async {
    await messagesRef.child(message.id).update(
          message.toJson(),
        );
  }

  @override
  ValueStream<DbMessageList> messagesOf({required Id chatId}) {
    return messagesRef.onValue.map(
      (event) {
        log.v(
            'Database -> messagesOf $chatId -> Event ${event.snapshot.value}');
        if (event.snapshot.exists) {
          final messages = event.snapshot.toModels(
            DbMessage.fromJson,
          );

          return messages
              .where(
                (e) => e.parentId == chatId,
              )
              .sorted((a, b) => a.dateTime.compareTo(b.dateTime))
              .toIList();
        }
        return IList<DbMessage>([]);
      },
    ).shareValueSeeded(
      IList([]),
    );
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await messagesRef.child(messageId).remove();
  }

  @override
  Future<void> deleteMessages(Iterable<Id> messagesId) async {
    messagesId.forEach(await deleteMessage);
  }
}
