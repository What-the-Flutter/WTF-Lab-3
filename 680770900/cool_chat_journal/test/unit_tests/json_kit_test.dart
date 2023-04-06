import 'dart:math';

import 'package:cool_chat_journal/data/json_kit.dart';
import 'package:flutter_test/flutter_test.dart';

enum TestedEnum { foo, bar, eggs, defaultValue }

void main() {
  group('BooleanConverter', () {
    group('fromJson', () {
      test('should returns false', () {
        final booleanConverter = const BooleanConverter();

        expect(booleanConverter.fromJson(0), false);
      });

      test('should returns true', () {
        final booleanConverter = const BooleanConverter();

        expect(booleanConverter.fromJson(1), true);
      });
    });

    group('toJson', () {
      test('should returns 0', () {
        final booleanConverter = const BooleanConverter();

        expect(booleanConverter.toJson(false), 0);
      });

      test('should returns 1', () {
        final booleanConverter = const BooleanConverter();

        expect(booleanConverter.toJson(true), 1);
      });
    });
  });
}