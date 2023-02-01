part of '../../view/chat_settings_page.dart';

class _MockMessageList extends StatelessWidget {
  const _MockMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WithBackgroundImage(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.large,
        ),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.isCenterDateBubbleShown)
                  TimeItem(
                    dateTime: DateTime.now(),
                  ),
                MessageItem(
                  message: Message(
                    id: '0',
                    text: 'Hello world',
                    dateTime: DateTime.now(),
                  ),
                ),
                MessageItem(
                  message: Message(
                    id: '1',
                    text: 'You can customize theme here',
                    dateTime: DateTime.now(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
