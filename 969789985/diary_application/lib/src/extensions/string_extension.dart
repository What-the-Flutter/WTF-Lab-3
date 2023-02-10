extension StringExtension on String {
  String excludeEmptyLines() {
    return split(RegExp(r'(?:\r?\n|\r)'))
        .where((s) => s.trim().isNotEmpty)
        .join('\n');
  }
}