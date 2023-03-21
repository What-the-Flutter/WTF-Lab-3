import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../util/typedefs.dart';

part 'db_activity_model.freezed.dart';

part 'db_activity_model.g.dart';

@freezed
class DBActivityModel with _$DBActivityModel {
  factory DBActivityModel({
    @Default('_id') FId id,
    required DateTime date,
    @Default('0') spentTime,
  }) = _DBActivityModel;

  factory DBActivityModel.fromJson(Map<String, dynamic> json) =>
      _$DBActivityModelFromJson(json);
}
