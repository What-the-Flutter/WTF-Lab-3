import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/models/message.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/radius.dart';
import '../../messages_manage/widget/message_list/items/message_item.dart';
import '../cubit/theme_cubit.dart';
import '../data/theme_repository.dart';

class ChooseColorSheet extends StatelessWidget {
  ChooseColorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MessageItem(
                message: Message(
                  text: 'Some long example message',
                ),
              ),
              MessageItem(
                message: Message(
                  text: 'Some selected and favorite message',
                  isFavorite: true,
                ),
                isSelected: true,
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  top: Insets.extraLarge,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 35,
                  mainAxisSpacing: Insets.extraLarge,
                  crossAxisSpacing: Insets.extraLarge,
                ),
                itemCount: ThemeRepository.colors.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(Radius.extraLarge),
                    onTap: () {
                      context.read<ThemeCubit>().color =
                          ThemeRepository.colors[index];
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ThemeRepository.colors[index],
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          Insets.extraSmall,
                        ),
                        child: state.color == ThemeRepository.colors[index]
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    width: 3,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
