import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/themes/widget/theme_scope.dart';
import '../../../../../../common/values/dimensions.dart';
import '../../../../domain/chat_model.dart';
import '../../../pages/chatter_archive_page.dart';
import 'archive_card_content.dart';

class ArchiveCard extends StatelessWidget {
  final IList<ChatModel> archiveList;

  ArchiveCard({
    super.key,
    required this.archiveList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.small,
        right: Insets.small,
        bottom: Insets.small,
      ),
      child: Card(
        color: Color(ThemeScope.of(context).state.primaryItemColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.appConstant),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArchiveChatScreen(),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              left: Insets.appConstantSmall,
              right: Insets.appConstantSmall,
              top: Insets.appConstantLarge,
              bottom: Insets.appConstantLarge,
            ),
            child: ArchiveCardContent(),
          ),
        ),
      ),
    );
  }
}
