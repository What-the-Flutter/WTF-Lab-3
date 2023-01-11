class MessageData {
  final String message;
  final DateTime dateTime;
  bool isFavorite;

  MessageData(this.message, this.dateTime, [this.isFavorite = false]);
}