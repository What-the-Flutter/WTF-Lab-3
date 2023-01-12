import 'package:go_router/go_router.dart';

import 'common/widget/empty_page.dart';
import 'common/widget/home_page_navigation_bar.dart';
import 'features/chat/view/chat_page.dart';
import 'features/chat/view/message_search_page.dart';
import 'features/chat_overview/view/chat_overview_page.dart';
import 'features/manage_chat/manage_chat.dart';

final router = GoRouter(
  initialLocation: PagePaths.home.routePath,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomePageNavigationBar(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: PagePaths.home.routePath,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatOverviewPage(),
          ),
          routes: [
            GoRoute(
              path: PagePaths.chatAdding.routePath,
              builder: (context, state) => const ManageChatPage(),
            ),
            GoRoute(
              path: PagePaths.chatEditing.routePath,
              builder: (context, state) => ManageChatPage(
                chatId: int.parse(state.params['chatId']!),
              ),
            ),
          ],
        ),
        GoRoute(
          path: PagePaths.daily.routePath,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Daily',
            ),
          ),
        ),
        GoRoute(
          path: PagePaths.timeline.routePath,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Timeline',
            ),
          ),
        ),
        GoRoute(
          path: PagePaths.explore.routePath,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EmptyPage(
              title: 'Explore',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: PagePaths.chat.routePath,
      builder: (context, state) => ChatPage(
        chatId: int.parse(
          state.params['chatId']!,
        ),
      ),
      routes: [
        GoRoute(
          path: PagePaths.chatSearch.routePath,
          builder: (context, state) => MessageSearchPage(
            chatId: int.parse(state.params['chatId']!),
          ),
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);

enum PagePaths {
  home(routePath: '/home', path: '/home'),
  chatAdding(routePath: 'add', path: '/home/add'),
  chatEditing(routePath: 'edit/:chatId', path: '/home/edit/:chatId'),
  daily(routePath: '/daily', path: '/daily'),
  timeline(routePath: '/timeline', path: '/timeline'),
  explore(routePath: '/explore', path: '/explore'),
  chat(routePath: '/chat/:chatId', path: '/chat/:chatId'),
  chatSearch(routePath: 'search', path: '/chat/:chatId/search');

  const PagePaths({
    required this.routePath,
    required this.path,
  });

  final String routePath;
  final String path;
}
