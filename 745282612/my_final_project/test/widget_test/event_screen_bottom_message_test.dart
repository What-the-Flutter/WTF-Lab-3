import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_bottom_message.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';

class MockEventCubit extends MockCubit<EventState> implements EventCubit {}

class FakeEventState extends Fake implements EventState {}

void main() {
  final user = MockUser(
    isAnonymous: true,
  );
  setUpAll(() {
    registerFallbackValue(FakeEventState());
  });
  late EventCubit cubit;
  late TextEditingController controller;

  setUp(() {
    cubit = MockEventCubit();
    controller = TextEditingController();
  });
  group(
    'Test for Event Screen Bottom Message',
    () {
      testWidgets(
        'Load Widgets',
        (tester) async {
          when(() => cubit.state).thenReturn(
            EventState(
              listEvent: [],
            ),
          );
          final page = BlocProvider<EventCubit>.value(
            value: cubit,
            child: MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: BlocProvider(
                  create: (context) => SettingCubit(user: user),
                  child: EventScreenBottomMessage(
                    controller: controller,
                    isCamera: true,
                    chatId: 0,
                  ),
                ),
              ),
            ),
          );
          await tester.pumpWidget(page);
          expect(find.byType(TextField), findsOneWidget);
        },
      );
      testWidgets(
        'Input Text with switch',
        (tester) async {
          when(() => cubit.state).thenReturn(
            EventState(
              listEvent: [],
            ),
          );
          final page = BlocProvider<EventCubit>.value(
            value: cubit,
            child: MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: BlocProvider(
                  create: (context) => SettingCubit(user: user),
                  child: EventScreenBottomMessage(
                    controller: controller,
                    isCamera: false,
                    chatId: 0,
                  ),
                ),
              ),
            ),
          );
          await tester.pumpWidget(page);
          await tester.enterText(find.byType(TextField), 'home');
          expect(find.byIcon(Icons.send), findsOneWidget);
        },
      );
      testWidgets(
        'Switch Tag -> Section',
        (tester) async {
          when(() => cubit.state).thenReturn(
            EventState(
              listEvent: [],
            ),
          );
          final page = BlocProvider<EventCubit>.value(
            value: cubit,
            child: MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: BlocProvider(
                  create: (context) => SettingCubit(user: user),
                  child: EventScreenBottomMessage(
                    controller: controller,
                    isCamera: true,
                    chatId: 0,
                  ),
                ),
              ),
            ),
          );
          await tester.pumpWidget(page);
          await tester.longPress(find.byKey(const Key('Btn switch')));
          await tester.pump();
          expect(find.byIcon(Icons.bubble_chart), findsOneWidget);
        },
      );
    },
  );
}
