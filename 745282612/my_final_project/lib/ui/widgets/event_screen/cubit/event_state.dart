import 'package:my_final_project/entities/event.dart';

class EventState {
  final List<Event> listEvent;
  final bool isFavorite;
  final bool isSelected;
  final bool isEdit;
  final String editText;
  final bool isPicter;

  EventState({
    required this.listEvent,
    this.isFavorite = false,
    this.isSelected = false,
    this.isEdit = false,
    this.isPicter = false,
    this.editText = '',
  });

  EventState copyWith({
    bool? isSelected,
    bool? isFavorite,
    List<Event>? listEvent,
    bool? isEdit,
    String? editText,
    bool? isPicter,
  }) {
    return EventState(
      isSelected: isSelected ?? this.isSelected,
      listEvent: listEvent ?? this.listEvent,
      isFavorite: isFavorite ?? this.isFavorite,
      isEdit: isEdit ?? this.isEdit,
      editText: editText ?? this.editText,
      isPicter: isPicter ?? this.isPicter,
    );
  }
}
