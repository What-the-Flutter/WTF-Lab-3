extension StringExtensions on String {
  bool containsIgnoreCase(String part) {
    return toLowerCase().contains(part.toLowerCase());
  }

  String withArgs(Map<String, String> args) {
    return replaceAllMapped(
      RegExp(r':\w+'),
      (match) => args[match.group(0)]!,
    );
  }
}
