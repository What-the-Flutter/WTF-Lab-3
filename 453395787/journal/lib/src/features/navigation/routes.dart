import 'package:go_router/go_router.dart';

import '../../../pages/home_page.dart';
import '../chat_search/view/chat_search.dart';
import '../messages_manage/view/chat_page.dart';

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
              builder: (context, state) => ChatSearchPage(
                chatId: int.parse(state.params['id']!),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
