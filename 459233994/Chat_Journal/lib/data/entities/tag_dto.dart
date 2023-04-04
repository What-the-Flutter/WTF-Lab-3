import '../../domain/entities/tag.dart';

class TagDTO {
  final String? id;
  final String name;

  TagDTO({
    this.id,
    required this.name,
  });

  factory TagDTO.fromJSON(Map<String, dynamic> json) {
    return TagDTO(
      id: json['tag_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };

  Tag toModel() {
    return Tag(name: name);
  }
}
