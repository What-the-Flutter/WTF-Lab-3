class Chat {
  final String title, description;
  final List<String>? messages;

  Chat({
    required this.title,
    required this.description,
    this.messages,
  });
}
