extension IterableExtensions on Iterable {
  bool containsAll(Iterable other) {
    if (runtimeType == other.runtimeType) {
      for (var item in other) {
        if (!contains(item)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
