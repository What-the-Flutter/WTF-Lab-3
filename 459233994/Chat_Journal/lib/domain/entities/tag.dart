class Tag {
  final String? id;
  final String name;

  Tag({required this.name, this.id});

  Tag copyWith({
    String? id,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
