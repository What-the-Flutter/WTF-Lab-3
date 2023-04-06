import 'package:collection/collection.dart';

class Converter<T extends Enum> {
  final List<T> values;
  final T defaultValue;

  const Converter({
    required this.values,
    required this.defaultValue,
  });

  T fromString(String value) =>
      values.firstWhereOrNull((e) => e.name == value) ?? defaultValue;
}
