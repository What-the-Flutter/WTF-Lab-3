import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/db/activity/db_activity_model.dart';
import '../../../domain/models/local/activity/activity_model.dart';
import '../../../domain/provider/activity/api_activity_provider.dart';
import '../../../util/extension/snapshot_extension.dart';
import '../../../util/logger.dart';
import '../../../util/typedefs.dart';
import '../reference/activity_reference.dart';

class ActivitySource extends ActivityReference implements ApiActivityProvider {
  final FId _firebaseUserId;

  ActivitySource({
    required FId firebaseUserId,
  }) : _firebaseUserId = firebaseUserId {
    _initializeActivitiesStream();
  }

  @override
  FId get firebaseUserId => _firebaseUserId;

  @override
  ValueStream<IList<DBActivityModel>> get activities => _activities.stream;

  final BehaviorSubject<IList<DBActivityModel>> _activities =
  BehaviorSubject.seeded(
    IList<DBActivityModel>([]),
  );

  Future<void> _initializeActivitiesStream() async {
    activityReference.keepSynced(true);

    final availableActivities =
    await activityReference.once(DatabaseEventType.value);

    _activities.add(
      availableActivities.snapshot.toModels(DBActivityModel.fromJson),
    );

    activityReference.onValue.listen(
          (dbEvent) {
        final activity = dbEvent.snapshot.toModels(DBActivityModel.fromJson);

        _activities.add(
          activity.sort(
                (a, b) => a.date.compareTo(b.date),
          ),
        );
      },
    );
  }

  @override
  Future<FId> addActivity(DBActivityModel date) async {
    final reference = activityReference.push();

    await reference.set(
      date.copyWith(id: reference.key!).toJson(),
    );

    return reference.key!;
  }

  @override
  Future<void> updateActivity(DBActivityModel date) async {
    await activityReference.child(date.id).update(date.toJson());
  }

  @override
  Future<void> deleteActivity(FId activityId) async {
    await activityReference.child(activityId).remove();
  }

  @override
  StreamTransformer<IList<DBActivityModel>, IList<ActivityModel>>
  get activityStreamTransformer => StreamTransformer<IList<DBActivityModel>,
      IList<ActivityModel>>.fromHandlers(
    handleData: (value, sink) {
      logger('$value', 'Activities_transform_value');
      sink.add(
        activitiesList(value),
      );
    },
  );

  @override
  IList<ActivityModel> activitiesList(IList<DBActivityModel> availableDates) {
    return availableDates.map(activity).toIList();
  }

  @override
  ActivityModel activity(DBActivityModel availableChat) {
    return ActivityModel(
      id: availableChat.id,
      date: availableChat.date,
      spentTime: availableChat.spentTime,
    );
  }

  @override
  DBActivityModel dbActivity(ActivityModel chat) {
    return DBActivityModel(
      id: chat.id,
      date: chat.date,
      spentTime: chat.spentTime,
    );
  }
}
