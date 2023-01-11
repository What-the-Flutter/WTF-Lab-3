class MessageData {
  final String message;
  final DateTime dateTime;
  bool isFavorite;
  final String? photoPath;

  MessageData(this.message, this.dateTime,
      {this.isFavorite = false, this.photoPath});
}
