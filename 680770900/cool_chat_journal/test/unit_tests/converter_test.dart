import 'package:cool_chat_journal/utils/converter.dart';
import 'package:flutter_test/flutter_test.dart';

enum TestedEnum { foo, bar, eggs, defaultValue }

void main() {
  group('Converter', () {
    test('Should return correct value', () {
      final converter = const Converter<TestedEnum>(
        values: TestedEnum.values,
        defaultValue: TestedEnum.defaultValue,
      );

      expect(converter.fromString('bar'), TestedEnum.bar);
    });

    test('Should return default value', () {
      final converter = const Converter<TestedEnum>(
        values: TestedEnum.values,
        defaultValue: TestedEnum.defaultValue,
      );

      expect(converter.fromString('errorValue'), TestedEnum.defaultValue);
    });
  });
}
