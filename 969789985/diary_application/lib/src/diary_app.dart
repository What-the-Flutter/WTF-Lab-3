import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/database/chat_database.dart';
import 'common/themes/cubit/theme_cubit.dart';
import 'common/themes/themes/themes.dart';
import 'common/themes/widget/theme_scope.dart';
import 'features/chat_list/data/repo/chat_repository.dart';
import 'features/start_screen.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ChatDatabase(),
      child: RepositoryProvider(
        create: (context) => ChatRepository(
          provider: context.read<ChatDatabase>(),
        ),
        child: ThemeScope(
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state.isDarkMode
                    ? Themes.getThemeFromKey(ThemeKeys.dark)
                    : Themes.getThemeFromKey(ThemeKeys.light),
                home: const StartScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
