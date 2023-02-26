import 'package:equatable/equatable.dart';

class CreateChatState extends Equatable {
  final int counterId;
  final int selectedIconIndex;
  final bool isNotEmpty;
  final bool isCreatingMode;
  final bool isChanged;

  const CreateChatState({
    this.counterId = 0,
    this.selectedIconIndex = 0,
    this.isNotEmpty = false,
    this.isCreatingMode = true,
    this.isChanged = false,
  });

  CreateChatState copyWith({
    int? counterId,
    int? selectedIconIndex,
    bool? isNotEmpty,
    bool? isCreatingMode,
    bool? isChanged,
  }) {
    return CreateChatState(
      counterId: counterId ?? this.counterId,
      selectedIconIndex: selectedIconIndex ?? this.selectedIconIndex,
      isNotEmpty: isNotEmpty ?? this.isNotEmpty,
      isCreatingMode: isCreatingMode ?? this.isCreatingMode,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  @override
  List<Object?> get props => [
        counterId,
        selectedIconIndex,
        isNotEmpty,
        isCreatingMode,
        isChanged,
      ];
}
