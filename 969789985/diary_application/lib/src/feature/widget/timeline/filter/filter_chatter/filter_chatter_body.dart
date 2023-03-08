import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../theme/theme_scope.dart';
import 'filter_chatter_list.dart';

class FilterChatterBody extends StatelessWidget {
  const FilterChatterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                ThemeScope.of(context).state.messageBorderRadius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.large,
                horizontal: Insets.large,
              ),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.info,
                    size: IconsSize.extraLarge,
                  ),
                  SizedBox(width: Insets.medium),
                  Expanded(
                    child: Text(
                      'Timeline will display the messages of the selected chats.',
                      style: TextStyle(
                        fontSize: FontsSize.normal,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: Insets.medium),
        Expanded(
          child: FilterChatterList(),
        ),
      ],
    );
  }
}
