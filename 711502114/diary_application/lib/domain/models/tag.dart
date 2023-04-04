import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final String id, title;

  const Tag({required this.id, required this.title});

  Tag copyWith({String? id, String? title}) {
    return Tag(id: id ?? this.id, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [id, title];
}