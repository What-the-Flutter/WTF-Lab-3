class Chat {
  final int id;
  final int icon;
  final String name;
  final DateTime createdTime;
  final bool isPinned;

  const Chat({
    required this.id,
    required this.icon,
    required this.name,
    required this.createdTime,
    required this.isPinned,
  });

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      icon: map['icon'],
      name: map['name'],
      createdTime: DateTime.parse(map['createdTime']),
      isPinned: map['isPinned'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'icon': icon,
      'name': name,
      'createdTime': createdTime.toString(),
      'isPinned': isPinned,
    };
  }

}