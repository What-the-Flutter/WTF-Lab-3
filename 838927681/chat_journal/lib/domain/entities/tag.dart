class Tag {
  final String id;
  final String text;

  const Tag({required this.id, required this.text});

  Tag copyWith({String? id, String? text}) {
    return Tag(id: id ?? this.id, text: text ?? this.text);
  }
}
