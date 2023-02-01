class Event {
  final String text;
  final String imagePath;
  final int iconIndex;
  final DateTime dateTime;
  final bool isFavorite;
  final bool isSelected;

  const Event({
    required this.text,
    required this.dateTime,
    this.imagePath = '',
    this.iconIndex = 0,
    this.isFavorite = false,
    this.isSelected = false,
  });

  Event copyWith({
    String? text,
    DateTime? dateTime,
    String? imagePath,
    int? iconIndex,
    bool? isFavorite,
    bool? isSelected,
  }) {
    return Event(
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      imagePath: imagePath ?? this.imagePath,
      iconIndex: iconIndex ?? this.iconIndex,
      isFavorite: isFavorite ?? this.isFavorite,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
