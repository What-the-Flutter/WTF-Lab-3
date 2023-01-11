import 'package:my_final_project/entities/section.dart';

class MenuState {
  final int index;
  final List<Section> listSection;
  final bool isAdd;

  MenuState({
    this.isAdd = false,
    required this.index,
    required this.listSection,
  });

  MenuState copyWith({
    int? index,
    List<Section>? listSection,
    bool? isAdd,
  }) {
    return MenuState(
      isAdd: isAdd ?? this.isAdd,
      index: index ?? this.index,
      listSection: listSection ?? this.listSection,
    );
  }
}
