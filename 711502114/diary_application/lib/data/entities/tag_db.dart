import 'package:equatable/equatable.dart';

class TagDB extends Equatable {
  final String id;
  final String title;

  TagDB({required this.id, required this.title});

  Map<String, dynamic> get map {
    return {
      'id': id,
      'title': title,
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
      id: (map['id'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
    );
  }

  @override
  List<Object?> get props => [id, title];
}
