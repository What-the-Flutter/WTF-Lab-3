import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mockito/mockito.dart' as mockito;
import 'package:bloc_test/bloc_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:diary_application/src/feature/cubit/timeline/timeline_cubit.dart';
import 'package:diary_application/src/feature/cubit/main/start_screen_cubit.dart';
import 'package:diary_application/src/feature/cubit/theme/theme_cubit.dart';
import 'package:diary_application/src/feature/widget/main/bottom_navigation_gnav.dart';
import 'package:diary_application/src/feature/widget/main/animated_main_title.dart';

import '../app_tester.dart';
import '../../utils/mock_theme_scope.mocks.dart';
import '../../utils/mock_start_screen_scope.mocks.dart';

class MockTimelineCubit extends MockCubit<TimelineState>
    implements TimelineCubit {}

void main() async {
  group('Bottom navigation bar', () {
    late TimelineCubit timelineCubit;
    late TimelineState timelineState;

    late ThemeCubit themeCubit;
    late ThemeState themeState;

    late StartScreenCubit startScreenCubit;
    late StartScreenState startScreenState;

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

      timelineCubit = MockTimelineCubit();
      timelineState = TimelineState.defaultMode(
        messages: IListConst([]),
        defaultMessages: IListConst([]),
        chats: IListConst([]),
        tags: IListConst([]),
        isFiltered: false,
      );

      startScreenCubit = MockStartScreenCubit();
      startScreenState = const StartScreenState(
        pageIndex: 0,
        fabVisible: false,
        gNavVisible: true,
        hashtag: '',
      );

      mockito.when(themeCubit.stream).thenAnswer(
            (_) => Stream<MockThemeState>.empty(),
          );
      mockito.when(startScreenCubit.stream).thenAnswer(
            (_) => Stream<MockStartScreenState>.empty(),
          );
      mocktail.when(() => timelineCubit.stream).thenAnswer(
            (_) => Stream<TimelineState>.empty(),
          );

      mockito.when(themeCubit.state).thenReturn(themeState);
      mockito.when(startScreenCubit.state).thenReturn(startScreenState);
      mocktail.when(() => timelineCubit.state).thenReturn(timelineState);
    });

    testWidgets('should render', (widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>.value(value: themeCubit),
            BlocProvider<StartScreenCubit>.value(value: startScreenCubit),
            BlocProvider<TimelineCubit>.value(value: timelineCubit),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, __) {
              return BlocBuilder<StartScreenCubit, StartScreenState>(
                builder: (_, __) {
                  return BlocBuilder<TimelineCubit, TimelineState>(
                    builder: (_, __) {
                      return AppTester(
                        bottomNavBarWidget: BottomNavigationGNav(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );

      expect(find.byType(GNav), findsOneWidget);
    });

    testWidgets('should change index on tap', (widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>.value(value: themeCubit),
            BlocProvider<StartScreenCubit>.value(value: startScreenCubit),
            BlocProvider<TimelineCubit>.value(value: timelineCubit),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, __) {
              return BlocBuilder<StartScreenCubit, StartScreenState>(
                builder: (_, __) {
                  return BlocBuilder<TimelineCubit, TimelineState>(
                    builder: (_, __) {
                      return AppTester(
                        appBarTitle: AnimatedMainTitle(),
                        bodyWidget: BottomNavigationGNav(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );

      final gButtonStatistic = find.byWidgetPredicate(
        (widget) => widget is GButton && widget.text == 'Statistic',
      );

      await widgetTester.tap(gButtonStatistic);
      await widgetTester.pumpAndSettle();

      expect(gButtonStatistic, findsOneWidget);
      mockito.verify(startScreenCubit.pageIndex = 2).called(1);
    });
  });
}
