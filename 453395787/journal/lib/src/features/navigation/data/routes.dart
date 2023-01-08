import 'package:go_router/go_router.dart';

import '../../../../pages/home_page.dart';
import '../../../common/data/models/chat.dart';
import '../../chat_adding_editing/view/manage_chat_page.dart';
import '../../message_search/view/message_search_page.dart';
import '../../messages_manage/view/chat_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: 'Home'),
      routes: [
        GoRoute(
          path: 'chat/:id',
          builder: (context, state) => ChatPage(
            chatId: int.parse(state.params['id']!),
          ),
          routes: [
            GoRoute(
              path: 'search',
              builder: (context, state) => MessageSearchPage(
                id: state.extra! as int,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'add',
          builder: (context, state) => const ManageChatPage(),
        ),
        GoRoute(
          path: 'edit',
          builder: (context, state) => ManageChatPage(
            forEdit: state.extra! as Chat,
          ),
        ),
      ],
    ),
  ],
);
