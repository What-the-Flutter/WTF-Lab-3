import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../util/typedefs.dart';

part 'activity_model.freezed.dart';

@freezed
class ActivityModel with _$ActivityModel {
  factory ActivityModel({
    @Default('_id') FId id,
    required DateTime date,
    @Default('0') spentTime,
  }) = _ActivityModel;
}
