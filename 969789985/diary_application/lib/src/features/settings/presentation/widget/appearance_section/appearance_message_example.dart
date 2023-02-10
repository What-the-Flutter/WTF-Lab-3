import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/painter/triangle.dart';
import '../../../../../common/themes/cubit/theme_cubit.dart';
import '../../../../../common/values/dimensions.dart';
import '../../../../chat/domain/message_model.dart';
import '../../../../chat/presentation/widget/message/message_card.dart';

class AppearanceMessageExample extends StatelessWidget {
  final String message;

  const AppearanceMessageExample({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: Insets.medium),
          child: MessageCard(
            message: MessageModel(messageText: message),
            pressedAction: () {},
            longPressAction: () {},
            isExample: true,
          ),
        );
      },
    );
  }
}
