import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/datasource/source/chat_source.dart';
import 'core/data/datasource/source/message_source.dart';
import 'core/data/datasource/source/storage_source.dart';
import 'core/data/datasource/source/tag_source.dart';
import 'core/data/repository/chat/chat_repository.dart';
import 'core/util/resources/themes.dart';
import 'core/util/typedefs.dart';
import 'feature/cubit/theme/theme_cubit.dart';
import 'feature/page/safety/safety_page.dart';
import 'feature/widget/settings/security_section/scope/security_scope.dart';
import 'feature/widget/theme/theme_scope.dart';

class DiaryApp extends StatelessWidget {
  final FId firebaseUid;

  const DiaryApp({
    super.key,
    required this.firebaseUid,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ChatSource(
            firebaseUserId: firebaseUid,
          ),
        ),
        RepositoryProvider(
          create: (context) => ChatRepository(
            provider: context.read<ChatSource>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => MessageSource(
            firebaseUserId: firebaseUid,
          ),
        ),
        RepositoryProvider(
          create: (context) => TagSource(
            firebaseUserId: firebaseUid,
          ),
        ),
        RepositoryProvider(
          create: (context) => StorageSource(
            firebaseUserId: firebaseUid,
          ),
        ),
      ],
      child: ThemeScope(
        child: SecurityScope(
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
    );
  }
}
