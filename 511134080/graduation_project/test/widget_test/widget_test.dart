import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/models/event.dart';
import 'package:graduation_project/pages/settings/settings_cubit.dart';
import 'package:graduation_project/providers/settings_provider.dart';
import 'package:graduation_project/widgets/custom_drawer.dart';
import 'package:graduation_project/widgets/date_card.dart';
import 'package:graduation_project/widgets/event_card.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets(
    'test eventCard',
    (tester) async {
      final date = DateTime.now();
      final settingsProvider = SettingsProvider();

      final widget = MaterialApp(
        home: BlocProvider(
          create: (_) => SettingsCubit(provider: settingsProvider),
          lazy: false,
          child: EventCard(
            event: Event(
              title: 'hello world!',
              time: date,
              id: '1',
              chatId: '1',
              chatTitle: 'chat1',
              isFavourite: true,
              isSelected: true,
            ),
            key: UniqueKey(),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      expect(
        find.text(
          '${DateFormat('hh:mm a').format(date)}',
          findRichText: true,
        ),
        findsOneWidget,
      );

      expect(
        find.byIcon(
          Icons.bookmark,
        ),
        findsOneWidget,
      );

      expect(
        find.byIcon(
          Icons.check_circle,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'test dateCard',
    (tester) async {
      final date = DateTime.now();
      final settingsProvider = SettingsProvider();
      final widget = MaterialApp(
        home: BlocProvider(
          create: (_) => SettingsCubit(provider: settingsProvider),
          child: DateCard(
            date: date,
          ),
        ),
      );
      await tester.pumpWidget(widget);

      expect(find.text('05.04.2023'), findsOneWidget);
    },
  );

  testWidgets(
    'test CustomDrawer',
    (tester) async {
      final date = DateTime.now();
      final widget = MaterialApp(
        home: CustomDrawer(),
      );
      await tester.pumpWidget(widget);

      expect(find.text('Apr 05, 2023'), findsOneWidget);
    },
  );
}
