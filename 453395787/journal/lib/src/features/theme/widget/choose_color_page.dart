import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../common/models/db/db_message.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../chat/chat.dart';
import '../cubit/theme_cubit.dart';
import 'color_selector.dart';
import 'theme_scope.dart';

class ChoiceColorSheet extends StatelessWidget {
  const ChoiceColorSheet({
    super.key,
    this.showExampleMessages = true,
    this.showDarkModeButton = false,
  });

  final bool showDarkModeButton;
  final bool showExampleMessages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        Insets.large,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showDarkModeButton)
            _ThemeToggleButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleDarkMode();
              },
            ),
          if (showExampleMessages)
            MessageItem(
              message: Message(
                text: locale.Other.messageExampleText1.i18n(),
                dateTime: DateTime.now(),
              ),
            ),
          if (showExampleMessages)
            MessageItem(
              message: Message(
                text: locale.Other.messageExampleText2.i18n(),
                dateTime: DateTime.now(),
                isFavorite: true,
              ),
              isSelected: true,
            ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ColorSelector(
                onTap: (color) {
                  ThemeScope.of(context).color = color;
                },
                selectedColor: state.color,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.watch<ThemeCubit>().state.isDarkMode
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
      ),
      onPressed: onPressed,
    );
  }
}
