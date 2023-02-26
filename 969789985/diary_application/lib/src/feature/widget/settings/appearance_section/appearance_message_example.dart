import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/painter/triangle.dart';
import '../../../cubit/theme/theme_cubit.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../chat/message/message_card.dart';

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
