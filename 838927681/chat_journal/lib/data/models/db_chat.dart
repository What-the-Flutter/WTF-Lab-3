class DBChat {
  final int id;
  final String name;
  final int iconIndex;
  final String creationDate;

  DBChat({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconIndex': iconIndex,
      'creationDate': creationDate,
    };
  }
}
