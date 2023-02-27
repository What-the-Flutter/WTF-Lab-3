import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/message/message_model.dart';
import '../../../../../core/util/extension/datetime_extension.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../chat/message/message_card.dart';
import '../../../theme/theme_scope.dart';

class AppearanceMessageExample extends StatelessWidget {
  const AppearanceMessageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: state.dateBubbleVisible
              ? Curves.fastOutSlowIn
              : Curves.decelerate,
          decoration: BoxDecoration(
            color: state.chatBackgroundColor == -1
                ? null
                : Color(ThemeScope.of(context).state.chatBackgroundColor),
            image: state.imagePath == ''
                ? null
                : DecorationImage(
                    image: FileImage(state.image!),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: Insets.medium,
              left: Insets.medium,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: Insets.small),
                _DateBubble(state: state),
                const SizedBox(height: Insets.small),
                MessageCard(
                  message: MessageModel(messageText: 'Hello! ☺'),
                  pressedAction: () {},
                  longPressAction: () {},
                  isExample: true,
                ),
                const SizedBox(height: Insets.small),
                MessageCard(
                  message: MessageModel(
                    messageText:
                        'We hope you are in a great mood today, because it is important for us!',
                  ),
                  pressedAction: () {},
                  longPressAction: () {},
                  isExample: true,
                ),
                const SizedBox(height: Insets.small),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DateBubble extends StatelessWidget {
  final ThemeState state;

  const _DateBubble({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: state.dateBubbleVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: state.dateBubbleVisible ? 40.0 : 0.0,
            child: Center(
              child: Card(
                elevation: 0,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(Insets.medium),
                  child: Text(
                    DateTime.now().dateYMMMDFormat(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
