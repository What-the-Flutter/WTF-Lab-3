import 'package:flutter/material.dart';

import '../chat_repository.dart';
import '../utils/styles.dart';
import '../utils/theme.dart';
import 'chat/chat_message_list.dart';

class ChooseColorSheet extends StatefulWidget {
  ChooseColorSheet({
    super.key,
  });

  @override
  State<ChooseColorSheet> createState() => _ChooseColorSheetState();
}

class _ChooseColorSheetState extends State<ChooseColorSheet> {
  int? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MessageItem(
                message: Message(
                  text: 'Some long example message',
                ),
                onTap: (_, __) {},
                onLongPress: (_, __) {},
                isSelected: false,
              ),
              MessageItem(
                message: Message(
                    text: 'Some selected and favorite message',
                    isFavorite: true),
                onTap: (_, __) {},
                onLongPress: (_, __) {},
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
                itemCount: AppTheme.colors.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(Radius.extraLarge),
                    onTap: () {
                      ThemeChanger.of(context).appTheme.color =
                          AppTheme.colors[index];
                      if (_selectedColor == index) {
                        setState(() => _selectedColor = null);
                      } else {
                        setState(() => _selectedColor = index);
                      }
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppTheme.colors[index],
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          Insets.extraSmall,
                        ),
                        child: _selectedColor == index
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
        ),
      ),
    );
  }
}
