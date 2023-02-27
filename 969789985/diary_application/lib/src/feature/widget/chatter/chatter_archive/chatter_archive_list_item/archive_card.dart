import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../page/chatter/chatter_archive_page.dart';
import '../../../theme/theme_scope.dart';
import 'archive_card_content.dart';

class ArchiveCard extends StatelessWidget {
  ArchiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.small,
        right: Insets.small,
        bottom: Insets.small,
      ),
      child: Card(
        color: Color(ThemeScope.of(context).state.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ThemeScope.of(context).state.messageBorderRadius,
          ),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ThemeScope.of(context).state.messageBorderRadius,
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArchiveChatScreen(),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              top: Insets.appConstantMedium,
              bottom: Insets.appConstantMedium,
            ),
            child: ArchiveCardContent(),
          ),
        ),
      ),
    );
  }
}
