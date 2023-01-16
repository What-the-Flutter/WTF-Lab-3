import 'package:my_final_project/entities/section.dart';

class SettingsState {
  final List<Section> listSection;
  final bool isAdd;

  SettingsState({
    this.isAdd = false,
    required this.listSection,
  });

  SettingsState copyWith({
    List<Section>? listSection,
    bool? isAdd,
  }) {
    return SettingsState(
      isAdd: isAdd ?? this.isAdd,
      listSection: listSection ?? this.listSection,
    );
  }
}
