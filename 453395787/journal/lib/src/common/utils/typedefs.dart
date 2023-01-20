import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../models/db/db_chat.dart';
import '../models/db/db_message.dart';
import '../models/db/db_tag.dart';

typedef TagList = IList<DbTag>;
typedef MessageList = IList<DbMessage>;
typedef ChatViewList = IList<DbChat>;

typedef Id = String;