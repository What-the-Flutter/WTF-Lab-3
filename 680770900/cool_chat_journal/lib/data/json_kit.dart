import 'package:json_annotation/json_annotation.dart';

typedef JsonMap = Map<String, dynamic>;

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(int json) => json != 0;

  @override
  int toJson(bool object) => object ? 1 : 0;
}
