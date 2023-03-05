part of 'chat_editor_cubit.dart';

class ChatEditorState extends Equatable {
  final int iconIndex;
  final String title;

  const ChatEditorState({
    this.iconIndex = 0,
    this.title = '',
  });

  ChatEditorState copyWith({
    int? iconIndex,
    String? title,
  }) => ChatEditorState(
    iconIndex: iconIndex ?? this.iconIndex,
    title: title ?? this.title,
  );

  @override
  List<Object> get props => [iconIndex, title];
}