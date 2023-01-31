import 'package:rxdart/rxdart.dart';

import '../../utils/filter.dart';
import '../../utils/typedefs.dart';

abstract class MessageOverviewRepositoryApi {
  ValueStream<MessageList> get messages;

  void filter(Filter filter);
}
