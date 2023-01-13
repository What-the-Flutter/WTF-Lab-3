class MessageData {
  final String message;
  final DateTime dateTime;
  bool isFavorite;
  bool isSelected;
  final String? photoPath;

  MessageData(
    this.message,
    this.dateTime, {
    this.isFavorite = false,
    this.isSelected = false,
    this.photoPath,
  });

  @override
  String toString() => message;
}
