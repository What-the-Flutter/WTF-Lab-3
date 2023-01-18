import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../common/models/message.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../chat/chat.dart';
import '../cubit/theme_cubit.dart';
import 'color_selector.dart';
import 'theme_scope.dart';

class ChoiceColorSheet extends StatelessWidget {
  const ChoiceColorSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MessageItem(
                message: Message(
                  text: locale.Other.messageExampleText1.i18n(),
                ),
              ),
              MessageItem(
                message: Message(
                  text: locale.Other.messageExampleText2.i18n(),
                  isFavorite: true,
                ),
                isSelected: true,
              ),
              ColorSelector(
                onTap: (color) {
                  ThemeScope.of(context).color = color;
                },
                selectedColor: state.color,
              ),
            ],
          ),
        );
      },
    );
  }
}
