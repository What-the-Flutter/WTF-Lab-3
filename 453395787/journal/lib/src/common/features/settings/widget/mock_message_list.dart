import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/chat/chat.dart';
import '../../../models/ui/message.dart';
import '../../../utils/insets.dart';
import '../cubit/settings_cubit.dart';

class MockMessageList extends StatelessWidget {
  const MockMessageList({super.key});

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
