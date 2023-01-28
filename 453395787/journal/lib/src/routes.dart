import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import 'common/features/settings/settings.dart';
import 'common/utils/locale.dart' as locale;
import 'common/widget/empty_page.dart';
import 'common/widget/home_page_navigation_bar.dart';
import 'features/chat/chat.dart';
import 'features/chat_overview/chats_overview.dart';
import 'features/manage_chat/manage_chat.dart';
import 'features/manage_tags/manage_tags.dart';

abstract class Navigation {
  static final GoRouter router = GoRouter(
    initialLocation: _routerHomePagePath,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return HomePageNavigationBar(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: _routerHomePagePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChatOverviewPage(),
            ),
            routes: [
              GoRoute(
                path: _routerAddChatPagePath,
                builder: (context, state) => const ManageChatPage(),
              ),
              GoRoute(
                path: _routerEditChatPagePath,
                builder: (context, state) => ManageChatPage(
                  chatId: state.params['chatId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: _routerDailyPagePath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: EmptyPage(
                title: locale.Pages.daily.i18n(),
              ),
            ),
          ),
          GoRoute(
            path: _routerTimelinePagePath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: EmptyPage(
                title: locale.Pages.timeline.i18n(),
              ),
            ),
          ),
          GoRoute(
            path: _routerSettingsPagePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsPage(),
            ),
            routes: [
              GoRoute(
                path: _routerChatSettingsPagePath,
                builder: (context, state) => const ChatSettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: _routerManageTagsPagePath,
        builder: (context, state) => const ManageTagsPage(),
      ),
      GoRoute(
        path: _routerChatPagePath,
        builder: (context, state) => ChatPage(
          chatId: state.params['chatId']!,
        ),
        routes: [
          GoRoute(
            path: _routerChatSearchPagePath,
            builder: (context, state) => MessageSearchPage(
              chatId: state.params['chatId']!,
            ),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );

  static const _routerHomePagePath = '/home';
  static const _routerAddChatPagePath = 'add';
  static const _routerEditChatPagePath = 'edit/:chatId';
  static const _routerDailyPagePath = '/daily';
  static const _routerTimelinePagePath = '/timeline';
  static const _routerSettingsPagePath = '/settings';
  static const _routerChatSettingsPagePath = 'chat';
  static const _routerChatPagePath = '/chat/:chatId';
  static const _routerManageTagsPagePath = '/tags';
  static const _routerChatSearchPagePath = 'search';

  static const homePagePath = _routerHomePagePath;
  static const addChatPagePath = '$_routerHomePagePath/'
      '$_routerAddChatPagePath';

  static const editChatPagePath = '$_routerHomePagePath/'
      '$_routerEditChatPagePath';
  static const dailyPagePath = _routerDailyPagePath;
  static const timelinePagePath = _routerTimelinePagePath;
  static const settingsPagePath = _routerSettingsPagePath;
  static const chatSettingsPagePath = '$_routerSettingsPagePath/'
      '$_routerChatSettingsPagePath';
  static const chatPagePath = _routerChatPagePath;
  static const manageTagsPagePath = _routerManageTagsPagePath;
  static const chatSearchPagePath = '$_routerChatPagePath/'
      '$_routerChatSearchPagePath';
}
