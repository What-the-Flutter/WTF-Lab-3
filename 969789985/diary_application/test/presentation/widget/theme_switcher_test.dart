import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:lottie/lottie.dart';

import 'package:diary_application/src/feature/widget/general/theme_switcher.dart';
import 'package:diary_application/src/feature/cubit/theme/theme_cubit.dart';

import '../../app_tester.dart';
import 'utils/mocked_theme_cubit.dart';

void main() async {
  group('Theme switcher', () {
    late ThemeCubit themeCubit;
    late ThemeState themeState;

    final f = MockedThemeScope();

    setUp(() {
      themeCubit = MockThemeCubit();
      themeState = const ThemeState(
        isDarkMode: false,
        messageFontSize: 0,
        messageBorderRadius: 0,
        primaryColor: 0,
        primaryItemColor: 0,
        messageAlignment: '',
        dateBubbleVisible: false,
        chatBackgroundColor: 0,
        imagePath: '',
        image: null,
      );

      when(themeCubit.stream).thenAnswer((_) => Stream<MockThemeState>.empty());
      when(themeCubit.state).thenReturn(themeState);
    });

    testWidgets('should build', (widgetTester) async {
      await widgetTester.pumpWidget(
        BlocProvider<ThemeCubit>.value(
          value: themeCubit,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, __) {
              return AppTester(
                actionsWidgets: [ThemeSwitcher()],
              );
            },
          ),
        ),
      );

      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('should pressed', (widgetTester) async {
      await widgetTester.pumpWidget(
        BlocProvider<ThemeCubit>.value(
          value: themeCubit,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, __) {
              return AppTester(
                actionsWidgets: [ThemeSwitcher()],
              );
            },
          ),
        ),
      );

      final lottie = find.byType(Lottie);

      await widgetTester.tap(lottie);
      await widgetTester.pumpAndSettle();

      verify(themeCubit.changeTheme()).called(1);
    });
  });
}
