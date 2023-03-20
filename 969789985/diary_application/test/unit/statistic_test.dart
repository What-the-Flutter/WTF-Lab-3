import 'dart:core';
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mockito/annotations.dart';
import 'package:diary_application/src/feature/cubit/statistic/statistic_cubit.dart';
import 'package:diary_application/src/core/domain/models/local/activity/activity_model.dart';
import 'package:diary_application/src/core/util/resources/strings.dart';
import 'package:diary_application/src/core/domain/repository/statistic/api_statistic_repository.dart';

import '../utils/mocked_entities.dart';
import '../utils/mock_statistic_scope.mocks.dart';

void main() async {
  group('Statistic unit tests', () {
    final mockStatisticRepository = MockApiStatisticRepository();
    late StatisticCubit statisticCubit;

    final activities = MockedActivities.activities;

    setUp(() {
      final activitiesSubject = BehaviorSubject.seeded(activities);

      mockito.when(mockStatisticRepository.activities).thenAnswer(
            (_) => activitiesSubject.stream,
          );

      statisticCubit = StatisticCubit(repository: mockStatisticRepository);
    });

    test('average of spent time', () {
      final averageSpent = statisticCubit.averageOfMinutes();

      expect(averageSpent, equals(4));
    });

    test('most used chat', () {
      final mostUsedChat = statisticCubit.mostUsedChat(
        MockedChats.chats,
        MockedMessages.messages,
      );

      expect(mostUsedChat.id, equals('3'));
    });

    test('yMax and entryDate', () async {
      await statisticCubit.updateEntryTime();

      expect(statisticCubit.state.yMax, equals(9));
      expect(
        statisticCubit.state.entryTime.minute,
        equals(DateTime.now().minute),
      );
    });
  });
}
