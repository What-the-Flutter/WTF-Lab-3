import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/models/theme_enums.dart';
import 'presentation/filters_page/filters_cubit.dart';
import 'presentation/presentation.dart';
import 'utils/custom_theme.dart';

class CoolChatJournalApp extends StatefulWidget {
  final User user;

  const CoolChatJournalApp({
    super.key,
    required this.user,
  });

  @override
  State<CoolChatJournalApp> createState() => _CoolChatJournalAppState();
}

class _CoolChatJournalAppState extends State<CoolChatJournalApp> {
  TextTheme _generateTextTheme(SettingsState state) {
    final fontSizeType = state.fontSizeType;

    final double defaultSize;
    switch (fontSizeType) {
      case FontSizeType.small:
        defaultSize = 14.0;
        break;
      case FontSizeType.medium:
        defaultSize = 16.0;
        break;
      case FontSizeType.large:
        defaultSize = 22.0;
        break;
    }

    return TextTheme(
      displayLarge: TextStyle(fontSize: defaultSize),
      displayMedium: TextStyle(fontSize: defaultSize),
      displaySmall: TextStyle(fontSize: defaultSize),
      headlineLarge: TextStyle(fontSize: defaultSize),
      headlineMedium: TextStyle(fontSize: defaultSize),
      headlineSmall: TextStyle(fontSize: defaultSize),
      titleLarge: TextStyle(fontSize: defaultSize),
      titleMedium: TextStyle(fontSize: defaultSize),
      titleSmall: TextStyle(fontSize: defaultSize),
      bodyLarge: TextStyle(fontSize: defaultSize),
      bodyMedium: TextStyle(fontSize: defaultSize),
      bodySmall: TextStyle(fontSize: defaultSize),
      labelLarge: TextStyle(fontSize: defaultSize),
      labelMedium: TextStyle(fontSize: defaultSize),
      labelSmall: TextStyle(fontSize: defaultSize),
    );
  }

  ThemeData _generateTheme(SettingsState state) {
    final themeKey = state.themeType;

    switch (themeKey) {
      case ThemeType.light:
        return FlexThemeData.light(
          useMaterial3: true,
          scheme: FlexScheme.blue,
          textTheme: _generateTextTheme(state),
        );
      case ThemeType.dark:
        return FlexThemeData.dark(
          useMaterial3: true,
          scheme: FlexScheme.blue,
          textTheme: _generateTextTheme(state),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => GetIt.I<SettingsCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => GetIt.I<HomeCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => GetIt.I<ChatCubit>(),
        ),
        BlocProvider<ChatEditorCubit>(
          create: (_) => GetIt.I<ChatEditorCubit>(),
        ),
        BlocProvider<FiltersCubit>(
          create: (_) => GetIt.I<FiltersCubit>(),
        ),
        BlocProvider<StatisticsCubit>(
          create: (_) => GetIt.I<StatisticsCubit>(),
        ),
      ],
      child: Builder(
        builder: (_) => BlocBuilder<SettingsCubit, SettingsState>(
          builder: (_, state) {
            final themeData = _generateTheme(state);
            return CustomTheme(
              themeData: themeData,
              themeType: state.themeType,
              bubbleAlignmentType: state.bubbleAlignmentType,
              fontSizeType: state.fontSizeType,
              backgroundImage: state.backgroundImage,
              child: MaterialApp(
                title: 'Cool Chat Journal',
                theme: themeData,
                home: const HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
