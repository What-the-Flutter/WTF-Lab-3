import 'package:rxdart/rxdart.dart';

import '../../utils/message_filter.dart';
import '../../utils/typedefs.dart';

abstract class MessageOverviewRepositoryApi {
  ValueStream<MessageList> get messages;

  void filter(MessageFilter filter);
}
