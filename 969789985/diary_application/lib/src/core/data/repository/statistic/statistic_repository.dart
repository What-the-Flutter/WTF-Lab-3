import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/local/activity/activity_model.dart';
import '../../../domain/provider/activity/api_activity_provider.dart';
import '../../../domain/repository/statistic/api_statistic_repository.dart';
import '../../../util/typedefs.dart';

class StatisticRepository extends ApiStatisticRepository {
  final ApiActivityProvider _provider;
  final Stopwatch _stopwatch;

  StatisticRepository({
    required ApiActivityProvider provider,
  })  : _provider = provider,
        _stopwatch = Stopwatch() {
    _stopwatch.start();
  }

  @override
  // TODO: implement activities
  ValueStream<IList<ActivityModel>> get activities => _provider.activities
      .transform(_provider.activityStreamTransformer)
      .shareValueSeeded(
    _provider.activitiesList(
      _provider.activities.value,
    ),
  );

  @override
  Future<void> addActivity(ActivityModel activity) async {
    await _provider.addActivity(
      _provider.dbActivity(activity),
    );
  }

  @override
  Future<void> updateActivity(ActivityModel activity) async {
    await _provider.updateActivity(
      _provider.dbActivity(activity),
    );
  }

  @override
  Future<void> deleteActivity(FId activityId) async {
    await _provider.deleteActivity(activityId);
  }
}