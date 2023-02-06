import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../features/text_tags/model/text_tag.dart';
import '../models/db/db_chat.dart';
import '../models/db/db_message.dart';
import '../models/db/db_tag.dart';
import '../models/ui/chat.dart';
import '../models/ui/message.dart';
import '../models/ui/tag.dart';

typedef DbTagList = IList<DbTag>;
typedef DbMessageList = IList<DbMessage>;
typedef DbChatList = IList<DbChat>;

typedef TagList = IList<Tag>;
typedef TextTagList = IList<TextTag>;
typedef MessageList = IList<Message>;
typedef ChatList = IList<Chat>;
