class _DBChatKeys {
  static final id = 'id';
  static final name = 'name';
  static final iconIndex = 'iconIndex';
  static final creationDate = 'creationDate';
  static final lastMessage = 'lastMessage';
  static final lastDate = 'lastDate';
}

class DBChat {
  final String id;
  final String name;
  final int iconIndex;
  final String creationDate;
  final String lastMessage;
  final String lastDate;

  DBChat({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.creationDate,
    required this.lastDate,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconIndex': iconIndex,
      'creationDate': creationDate,
      'lastMessage': lastMessage,
      'lastDate': lastDate,
    };
  }

  DBChat copyWith({
    String? id,
    String? name,
    String? creationDate,
    int? iconIndex,
    String? lastDate,
    String? lastMessage,
  }) {
    return DBChat(
      id: id ?? this.id,
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      creationDate: creationDate ?? this.creationDate,
      lastDate: lastDate ?? this.lastDate,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  static DBChat fromJson(Map<dynamic, dynamic> map) {
    return DBChat(
      id: map[_DBChatKeys.id] as String,
      name: map[_DBChatKeys.name] as String,
      iconIndex: map[_DBChatKeys.iconIndex] as int,
      creationDate: map[_DBChatKeys.creationDate] as String,
      lastDate: map[_DBChatKeys.lastDate] as String,
      lastMessage: map[_DBChatKeys.lastMessage] as String,
    );
  }
}
