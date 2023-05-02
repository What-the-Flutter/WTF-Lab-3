import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_journal/presentation/screens/add_chat.dart';
import 'package:chat_journal/presentation/widgets/app_theme/inherited_theme.dart';
import 'package:chat_journal/presentation/widgets/app_theme/theme.dart';
import 'package:chat_journal/presentation/screens/settings/settings.dart';
import 'package:chat_journal/presentation/screens/settings/settings_cubit.dart';
import 'package:chat_journal/data/repos/shared_preferences_repository.dart';
import 'package:chat_journal/data/services/shared_preferences.dart';
import 'package:chat_journal/presentation/screens/home/home.dart';
import 'package:chat_journal/presentation/screens/home/home_cubit.dart';
import 'package:chat_journal/data/repos/chat_repository.dart';
import 'package:chat_journal/data/services/database_service.dart';

void main() {
  group(
    'widget test',
    () {
      testWidgets(
        'AddChatScreen should render properly',
        (tester) async {
          await tester.pumpWidget(
            InheritedAppTheme(
              themeData: CustomTheme.lightTheme,
              child: MaterialApp(
                home: AddChatScreen(),
              ),
            ),
          );

          expect(find.text('Create a new page'), findsOneWidget);
          expect(find.byType(TextField), findsOneWidget);
          expect(find.byType(GridView), findsOneWidget);
          expect(find.byType(FloatingActionButton), findsOneWidget);
        },
      );

      testWidgets(
        'build settings page',
        (tester) async {
          await tester.pumpWidget(
            InheritedAppTheme(
              themeData: CustomTheme.lightTheme,
              child: BlocProvider<SettingsCubit>(
                create: (context) => SettingsCubit(
                  sharedPreferencesRepository: SharedPreferencesRepository(
                    sharedPreferencesService: SharedPreferencesService(),
                  ),
                ),
                child: MaterialApp(
                  home: SettingsScreen(),
                ),
              ),
            ),
          );
          expect(find.text('Font Size'), findsOneWidget);
        },
      );

      testWidgets(
        'switch works',
        (tester) async {
          await tester.pumpWidget(
            InheritedAppTheme(
              themeData: CustomTheme.lightTheme,
              child: BlocProvider<SettingsCubit>(
                create: (context) => SettingsCubit(
                  sharedPreferencesRepository: SharedPreferencesRepository(
                    sharedPreferencesService: SharedPreferencesService(),
                  ),
                ),
                child: MaterialApp(
                  home: SettingsScreen(),
                ),
              ),
            ),
          );
          await tester.tap(find.byType(Switch).last);
          await tester.pump();
          expect(tester.widget<Switch>(find.byType(Switch).last).value, true);
        },
      );
    },
  );
}
