class _DBEventKeys {
  static final id = 'id';
  static final parentId = 'parentId';
  static final text = 'text';
  static final imagePath = 'imagePath';
  static final iconIndex = 'iconIndex';
  static final dateTime = 'dateTime';
  static final isFavorite = 'isFavorite';
}

class DBEvent {
  final String id;
  final String parentId;
  final String text;
  final String imagePath;
  final int iconIndex;
  final String dateTime;
  final bool isFavorite;

  const DBEvent({
    required this.id,
    required this.parentId,
    required this.text,
    required this.dateTime,
    required this.imagePath,
    required this.iconIndex,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'text': text,
      'dateTime': dateTime,
      'imagePath': imagePath,
      'iconIndex': iconIndex,
      'isFavorite': isFavorite,
    };
  }

  DBEvent copyWith({
    String? id,
    String? parentId,
    String? text,
    String? dateTime,
    String? imagePath,
    int? iconIndex,
    bool? isFavorite,
  }) {
    return DBEvent(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      imagePath: imagePath ?? this.imagePath,
      iconIndex: iconIndex ?? this.iconIndex,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  static DBEvent fromJson(Map<dynamic, dynamic> map) {
    return DBEvent(
      id: map[_DBEventKeys.id] as String,
      parentId: map[_DBEventKeys.parentId] as String,
      text: map[_DBEventKeys.text] as String,
      iconIndex: map[_DBEventKeys.iconIndex] as int,
      dateTime: map[_DBEventKeys.dateTime] as String,
      imagePath: map[_DBEventKeys.imagePath] as String,
      isFavorite: map[_DBEventKeys.isFavorite] as bool,
    );
  }
}
