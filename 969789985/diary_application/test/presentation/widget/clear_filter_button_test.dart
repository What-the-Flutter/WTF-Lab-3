import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mockito/mockito.dart' as mockito;
import 'package:bloc_test/bloc_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:diary_application/src/feature/cubit/timeline/timeline_cubit.dart';
import 'package:diary_application/src/feature/cubit/main/start_screen_cubit.dart';
import 'package:diary_application/src/feature/widget/main/clear_filter.dart';

import '../app_tester.dart';
import '../../utils/mock_start_screen_scope.mocks.dart';

class MockTimelineCubit extends MockCubit<TimelineState>
    implements TimelineCubit {}

void main() async {
  group('clear filter', () {
    late TimelineCubit timelineCubit;
    late TimelineState timelineState;

    late StartScreenCubit startScreenCubit;
    late StartScreenState startScreenState;

    setUp(() {
      timelineCubit = MockTimelineCubit();
      timelineState = TimelineState.defaultMode(
        messages: IListConst([]),
        defaultMessages: IListConst([]),
        chats: IListConst([]),
        tags: IListConst([]),
        isFiltered: true,
      );

      startScreenCubit = MockStartScreenCubit();
      startScreenState = const StartScreenState(
        pageIndex: 1,
        fabVisible: false,
        gNavVisible: true,
        hashtag: '',
      );

      mockito.when(startScreenCubit.stream).thenAnswer(
            (_) => Stream<MockStartScreenState>.empty(),
          );
      mocktail.when(() => timelineCubit.stream).thenAnswer(
            (_) => Stream<TimelineState>.empty(),
          );

      mockito.when(startScreenCubit.state).thenReturn(startScreenState);
      mocktail.when(() => timelineCubit.state).thenReturn(timelineState);
    });

    testWidgets('should render', (widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<StartScreenCubit>.value(value: startScreenCubit),
            BlocProvider<TimelineCubit>.value(value: timelineCubit),
          ],
          child: BlocBuilder<StartScreenCubit, StartScreenState>(
            builder: (_, __) {
              return BlocBuilder<TimelineCubit, TimelineState>(
                builder: (_, __) {
                  return AppTester(
                    actionsWidgets: [
                      ClearFilter(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );

      expectLater(find.byIcon(Icons.filter_list_off), findsOneWidget);
    });

    testWidgets('should tapped', (widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<StartScreenCubit>.value(value: startScreenCubit),
            BlocProvider<TimelineCubit>.value(value: timelineCubit),
          ],
          child: BlocBuilder<StartScreenCubit, StartScreenState>(
            builder: (_, __) {
              return BlocBuilder<TimelineCubit, TimelineState>(
                builder: (_, __) {
                  return AppTester(
                    actionsWidgets: [
                      ClearFilter(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );

      final clearFilterButton = find.byIcon(Icons.filter_list_off);

      await widgetTester.tap(clearFilterButton);

      expectLater(clearFilterButton, findsOneWidget);
      mocktail.verify(() => timelineCubit.clearFilters()).called(1);
    });
  });
}
