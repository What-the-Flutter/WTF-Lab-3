import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/datasource/source/activity_source.dart';
import 'core/data/datasource/source/chat_source.dart';
import 'core/data/datasource/source/message_source.dart';
import 'core/data/datasource/source/storage_source.dart';
import 'core/data/datasource/source/tag_source.dart';
import 'core/data/repository/chat/chat_repository.dart';
import 'core/util/resources/themes.dart';
import 'feature/cubit/f_authenticate/f_authenticate_cubit.dart';
import 'feature/cubit/theme/theme_cubit.dart';
import 'feature/page/safety/safety_page.dart';
import 'feature/widget/chatter/scope/chatter_scope.dart';
import 'feature/widget/f_authenticate/f_auth_scope.dart';
import 'feature/widget/main/scope/main_scope.dart';
import 'feature/widget/main/statistic/statistic_scope.dart';
import 'feature/widget/settings/security_section/scope/security_scope.dart';
import 'feature/widget/theme/theme_scope.dart';
import 'feature/widget/timeline/scope/timeline_scope.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _InitSource(
      child: ThemeScope(
        child: StatisticScope(
          child: SecurityScope(
            child: StartScreenScope(
              child: ChatterScope(
                child: TimelineScope(
                  child: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: state.isDarkMode
                            ? Themes.getThemeFromKey(ThemeKeys.dark)
                            : Themes.getThemeFromKey(ThemeKeys.light),
                        home: const SafetyPage(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InitSource extends StatelessWidget {
  final Widget child;

  const _InitSource({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FAuthScope(
      child: BlocBuilder<FAuthenticateCubit, FAuthenticateState>(
        builder: (context, state) {
          return state.when(
            unauthenticated: () => const Center(
              child: CircularProgressIndicator(),
            ),
            authenticate: (currentUserId) {
              return MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => ActivitySource(
                      firebaseUserId: currentUserId,
                    ),
                  ),
                  RepositoryProvider(
                    create: (context) => ChatSource(
                      firebaseUserId: currentUserId,
                    ),
                  ),
                  RepositoryProvider(
                    create: (context) => ChatRepository(
                      provider: context.read<ChatSource>(),
                    ),
                  ),
                  RepositoryProvider(
                    create: (context) => MessageSource(
                      firebaseUserId: currentUserId,
                    ),
                  ),
                  RepositoryProvider(
                    create: (context) => TagSource(
                      firebaseUserId: currentUserId,
                    ),
                  ),
                  RepositoryProvider(
                    create: (context) => StorageSource(
                      firebaseUserId: currentUserId,
                    ),
                  ),
                ],
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
