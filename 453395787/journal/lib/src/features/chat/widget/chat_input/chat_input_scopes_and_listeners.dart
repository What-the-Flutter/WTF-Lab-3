part of 'chat_input.dart';

class _ChatInputScopesAndListeners extends StatelessWidget {
  const _ChatInputScopesAndListeners({
    super.key,
    required this.chatId,
    required this.inputTextController,
    required this.onDefaultModeStarted,
    required this.onEditModeStarted,
    required this.child,
  });

  final String chatId;
  final TextEditingController inputTextController;
  final VoidCallback onDefaultModeStarted;
  final void Function(Message message) onEditModeStarted;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MessageInputScope(
      repository: ChatMessagesRepository(
        messageProvider: context.read<MessageFirebaseProvider>(),
        tagProvider: context.read<TagFirebaseProvider>(),
        storageProvider: context.read<StorageFirebaseProvider>(),
        chat: context.read<ChatRepository>().chats.value.firstWhere(
              (chat) => chat.id == chatId,
            ),
      ),
      child: Builder(
        builder: (context) {
          return TagSelectorScope(
            child: TextTagSelectorScope(
              child: _MessageManageBlocListener(
                onDefaultModeStarted: onDefaultModeStarted,
                onEditModeStarted: onEditModeStarted,
                child: _TextTagBlocListener(
                  inputTextController: inputTextController,
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
