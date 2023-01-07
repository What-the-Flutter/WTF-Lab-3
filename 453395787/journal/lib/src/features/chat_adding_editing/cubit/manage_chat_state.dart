part of 'manage_chat_cubit.dart';

@immutable
abstract class ManageChatState {
  const ManageChatState({
    this.selectedIcon,
    this.name = '',
  }) : isFabShown = selectedIcon != null && name != '';

  final int? selectedIcon;
  final String name;
  final bool isFabShown;

  ManageChatState copyWith({
    int? selectedIcon,
    String? name,
  });
}

class ManageChatAdding extends ManageChatState {
  const ManageChatAdding({
    super.selectedIcon,
    super.name,
  });

  @override
  ManageChatState copyWith({
    int? selectedIcon,
    String? name,
    bool? isFabShown,
  }) {
    return ManageChatAdding(
      selectedIcon: selectedIcon ?? super.selectedIcon,
      name: name ?? super.name,
    );
  }
}

class ManageChatEditing extends ManageChatState {
  final Chat chat;

  ManageChatEditing({
    required this.chat,
    int? selectedIcon,
    String? name,
  }) : super(
          selectedIcon: selectedIcon ?? ChatIcons.icons.indexOf(chat.icon),
          name: name ?? chat.name,
        );

  @override
  ManageChatState copyWith({Chat? chat, int? selectedIcon, String? name}) {
    return ManageChatEditing(
      chat: chat ?? this.chat,
      selectedIcon: selectedIcon ?? super.selectedIcon,
      name: name ?? super.name,
    );
  }
}

class ManageChatClosed extends ManageChatState {
  const ManageChatClosed({
    super.selectedIcon,
    super.name,
  });

  @override
  ManageChatClosed copyWith({
    int? selectedIcon,
    String? name,
  }) {
    return ManageChatClosed(
      selectedIcon: selectedIcon ?? super.selectedIcon,
      name: name ?? super.name,
    );
  }
}
