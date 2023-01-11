import 'package:go_router/go_router.dart';

import 'common/widget/empty_page.dart';
import 'common/widget/home_page_navigation_bar.dart';
import 'features/chat/view/chat_page.dart';
import 'features/chat/view/message_search_page.dart';
import 'features/chat_overview/view/chat_overview_page.dart';
import 'features/manage_chat/manage_chat.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomePageNavigationBar(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatOverviewPage(),
          ),
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) => const ManageChatPage(),
            ),
            GoRoute(
              path: 'edit/:chatId',
              builder: (context, state) => ManageChatPage(
                chatId: int.parse(state.params['chatId']!),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/daily',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Daily',
            ),
          ),
        ),
        GoRoute(
          path: '/timeline',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Timeline',
            ),
          ),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Explore',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/chat/:chatId',
      builder: (context, state) => ChatPage(
        chatId: int.parse(
          state.params['chatId']!,
        ),
      ),
      routes: [
        GoRoute(
          path: 'search',
          builder: (context, state) => MessageSearchPage(
            chatId: int.parse(state.params['chatId']!),
          ),
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);
