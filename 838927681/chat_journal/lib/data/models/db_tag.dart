abstract class DBTagKeys {
  static final id = 'id';
  static final text = 'text';
}

class DBTag {
  final String id;
  final String text;

  const DBTag({required this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {
      DBTagKeys.id: id,
      DBTagKeys.text: text,
    };
  }

  DBTag copyWith({String? id, String? text}) {
    return DBTag(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  static DBTag fromJson(Map<dynamic, dynamic> map) {
    return DBTag(
      id: map[DBTagKeys.id] as String,
      text: map[DBTagKeys.text] as String,
    );
  }
}
