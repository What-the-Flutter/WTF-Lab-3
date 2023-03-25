import 'package:test/test.dart';
import 'package:diary_application/src/core/util/extension/string_extension.dart';

void main() async {
  group('String extension test', () {
    const String threeSpace = 'fdsjgdshgldsjlgds\n\n\n';
    const String oneSpace = 'fdsfdsfds\nfdsfdsfds';
    const String oneEndSpace = 'fdsfdsfdsfdsfds\n';

    test('3 space', () {
      final result = threeSpace.excludeEmptyLines();

      expect(result, equals(threeSpace.substring(0, 17)));
    });

    test('1 space', () {
      final result = oneSpace.excludeEmptyLines();

      expect(result, equals(oneSpace));
    });

    test('1 end space', () {
      final result = oneEndSpace.excludeEmptyLines();

      expect(result, equals(oneEndSpace.substring(0, 15)));
    });
  });
}