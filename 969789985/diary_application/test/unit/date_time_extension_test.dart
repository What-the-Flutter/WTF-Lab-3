import 'dart:core';

import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:diary_application/src/core/util/extension/datetime_extension.dart';

void main() async {
  group('DateTime extension', () {
    late DateTime now;

    setUp(() => now = DateTime.now());

    test('right jm format', () {
      final jmFormat = DateFormat.jm().format(now);
      final jmFormatFromExtension = now.timeJmFormat();

      expect(jmFormatFromExtension, equals(jmFormat));
    });

    test('right ymmmd format', () {
      final yMMdFormat = DateFormat.yMMMd().format(now);
      final yMMdFormatFromExtension = now.dateYMMMDFormat();

      expect(yMMdFormatFromExtension, equals(yMMdFormat));
    });

    test('right day name - today', () {
      final day = now.dayOfWeekend();

      expect(day, equals('Today'));
    });

    test('right day name - day ago', () {
      final dayAgo = now.copyWith(day: now.day - 1);

      final day = dayAgo.dayOfWeekend();
      final rightDay = DateFormat('EEEE').format(dayAgo).substring(0, 3);

      expect(day, equals(rightDay));
    });

    test('right day name - 2 days ago', () {
      final dayAgo = now.copyWith(day: now.day - 2);

      final day = dayAgo.dayOfWeekend();
      final rightDay = DateFormat('EEEE').format(dayAgo).substring(0, 3);

      expect(day, equals(rightDay));
    });
  });
}
