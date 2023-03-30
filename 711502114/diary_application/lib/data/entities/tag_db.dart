import 'package:equatable/equatable.dart';

class TagDB extends Equatable {
  final String id, title;

  TagDB({required this.id, required this.title});

  Map<String, dynamic> get map {
    return {
      TagFields.id: id,
      TagFields.title: title,
    };
  }

  TagDB copyWith({String? id, String? title}) {
    return TagDB(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  static TagDB map2Json(Map<dynamic, dynamic> map) {
    return TagDB(
      id: map[TagFields.id] as String,
      title: map[TagFields.title] as String,
    );
  }

  @override
  List<Object?> get props => [id, title];
}

class TagFields {
  static String id = 'id';
  static String title = 'title';
}
