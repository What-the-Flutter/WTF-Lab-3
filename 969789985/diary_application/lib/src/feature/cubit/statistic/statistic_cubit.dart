import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/domain/models/local/activity/activity_model.dart';
import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/domain/models/local/message/message_model.dart';
import '../../../core/domain/repository/statistic/api_statistic_repository.dart';
import '../../../core/util/resources/strings.dart';

part 'statistic_cubit.freezed.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final ApiStatisticRepository _repository;

  late final StreamSubscription<IList<ActivityModel>> _subscription;

  StatisticCubit({
    required ApiStatisticRepository repository,
  })  : _repository = repository,
        super(
          StatisticState(
            activities: IList<ActivityModel>(),
            messages: IList<MessageModel>(),
            datesRange: IList([
              DateTime.now().copyWith(day: DateTime.now().day - 7),
              DateTime.now(),
            ]),
            entryTime: DateTime.now(),
            yMax: 0,
            dateSelection: MessageDateChartSelections.lastWeek,
          ),
        ) {
    _subscription = _repository.activities.listen(
      (activities) {
        if (activities.length == 8) {
          _repository.deleteActivity(activities.first.id);
        }

        var yMax = 0;
        if (activities.isNotEmpty) {
          yMax = activities
              .map(
                (activity) => (activity.spentTime / 60).floor() as int,
              )
              .toList()
              .reduce(max);
        }

        emit(
          state.copyWith(
            activities: activities
                .sorted(
                  (a, b) => a.date.compareTo(b.date),
                )
                .toIList(),
            yMax: yMax,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }

  DateTime messagesGraphXAxis(MessageModel message) {
    return state.dateSelection == MessageDateChartSelections.lastYear ||
            state.dateSelection == MessageDateChartSelections.lastSixMonth
        ? DateTime(
            message.sendDate.year,
            message.sendDate.month,
          )
        : DateTime(
            message.sendDate.year,
            message.sendDate.month,
            message.sendDate.day,
          );
  }

  int messagesGraphYAxis(
    IList<MessageModel> messages,
    MessageModel comparedMessage,
  ) {
    return messages
        .where(
          (mes) => state.dateSelection == MessageDateChartSelections.lastYear ||
                  state.dateSelection == MessageDateChartSelections.lastSixMonth
              ? DateTime(
                    mes.sendDate.year,
                    mes.sendDate.month,
                  ).compareTo(
                    DateTime(
                      comparedMessage.sendDate.year,
                      comparedMessage.sendDate.month,
                    ),
                  ) ==
                  0
              : DateTime(
                    mes.sendDate.year,
                    mes.sendDate.month,
                    mes.sendDate.day,
                  ).compareTo(
                    DateTime(
                      comparedMessage.sendDate.year,
                      comparedMessage.sendDate.month,
                      comparedMessage.sendDate.day,
                    ),
                  ) ==
                  0,
        )
        .length;
  }

  void updateMessageDateSelection(MessageDateChartSelections selection) {
    switch (selection) {
      case MessageDateChartSelections.lastWeek:
        _updateDatesRange(
          DateTime.now().copyWith(day: DateTime.now().day - 7),
          selection,
        );
        break;
      case MessageDateChartSelections.lastMonth:
        _updateDatesRange(
          DateTime.now().copyWith(day: DateTime.now().day - 30),
          selection,
        );
        break;
      case MessageDateChartSelections.lastSixMonth:
        _updateDatesRange(
          DateTime.now().copyWith(month: DateTime.now().month - 6),
          selection,
        );
        break;
      case MessageDateChartSelections.lastYear:
        _updateDatesRange(
          DateTime.now().copyWith(month: DateTime.now().month - 12),
          selection,
        );
        break;
      default:
        _updateDatesRange(
          DateTime.now().copyWith(day: DateTime.now().day - 7),
          selection,
        );
        break;
    }
  }

  void _updateDatesRange(
    DateTime firstValue,
    MessageDateChartSelections selection,
  ) {
    emit(
      state.copyWith(
        dateSelection: selection,
        datesRange: IList([firstValue, DateTime.now()]),
      ),
    );
  }

  Future<void> updateEntryTime() async {
    var yMax = 0;

    if (state.activities.isNotEmpty) {
      yMax = state.activities
          .map(
            (activity) => (activity.spentTime / 60).floor() as int,
          )
          .toList()
          .reduce(max);
    }

    emit(
      state.copyWith(
        entryTime: DateTime.now(),
        yMax: yMax,
      ),
    );
  }

  Future<void> addActivity(ActivityModel activity) async =>
      await _repository.addActivity(activity);

  Future<void> updateActivity(ActivityModel activity) async =>
      await _repository.updateActivity(activity);

  Future<void> dispatchAction() async {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    final activity = state.activities.firstWhereOrNull(
      (activity) => activity.date.compareTo(currentDate) == 0,
    );

    final diff = now.difference(state.entryTime);

    if (activity == null) {
      await addActivity(
        ActivityModel(
          date: currentDate,
          spentTime: diff.inSeconds,
        ),
      );
    } else {
      await updateActivity(
        activity.copyWith(spentTime: activity.spentTime + diff.inSeconds),
      );
    }
  }

  int averageOfMinutes() {
    if (state.activities.isEmpty) return 0;

    final average = state.activities.map((e) => e.spentTime).reduce(
              (a, b) => a + b,
            ) /
        state.activities.length;

    return ((average as double) / 60).floor();
  }

  ChatModel mostUsedChat(IList<ChatModel> chats, IList<MessageModel> messages) {
    if (chats.isEmpty || messages.isEmpty) return ChatModel(chatIcon: 0);

    final mostCommon = messages
        .fold<Map<String, int>>(
      {},
          (map, message) => map
        ..update(message.parentId, (value) => value + 1, ifAbsent: () => 1),
    )
        .entries
        .reduce((e1, e2) => e1.value > e2.value ? e1 : e2)
        .key;

    return chats.firstWhere((chat) => chat.id == mostCommon);
  }
}
