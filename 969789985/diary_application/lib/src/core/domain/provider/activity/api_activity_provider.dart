import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/db/activity/db_activity_model.dart';
import '../../models/local/activity/activity_model.dart';

abstract class ApiActivityProvider {
  ValueStream<IList<DBActivityModel>> get activities;

  StreamTransformer<IList<DBActivityModel>, IList<ActivityModel>>
  get activityStreamTransformer;

  Future<FId> addActivity(DBActivityModel activity);

  Future<void> updateActivity(DBActivityModel activity);

  Future<void> deleteActivity(FId activityId);

  IList<ActivityModel> activitiesList(IList<DBActivityModel> availableDates);

  ActivityModel activity(DBActivityModel availableChat);

  DBActivityModel dbActivity(ActivityModel chat);
}