class Chat {
  final String id;
  final String name;
  final int iconIndex;
  final DateTime creationDate;
  final String lastMessage;
  final DateTime lastDate;

  Chat({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.creationDate,
    this.lastMessage = 'No events. CLick to create one',
    required this.lastDate,
  });

  Chat copyWith({
    String? id,
    String? name,
    int? iconIndex,
    DateTime? creationDate,
    String? lastMessage,
    DateTime? lastDate,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      creationDate: creationDate ?? this.creationDate,
      lastMessage: lastMessage ?? this.lastMessage,
      lastDate: lastDate ?? this.lastDate,
    );
  }
}
