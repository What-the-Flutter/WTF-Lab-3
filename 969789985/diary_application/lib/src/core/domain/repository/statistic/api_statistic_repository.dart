import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/local/activity/activity_model.dart';

abstract class ApiStatisticRepository {
  ValueStream<IList<ActivityModel>> get activities;

  Future<void> addActivity(ActivityModel activity);

  Future<void> updateActivity(ActivityModel activity);

  Future<void> deleteActivity(FId activityId);
}
