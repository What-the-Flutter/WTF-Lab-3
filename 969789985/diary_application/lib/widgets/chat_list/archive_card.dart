import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/providers/chat_list_provider.dart';
import '../../ui/screens/chat/archive_chats_screen.dart';
import '../../ui/utils/dimensions.dart';
import '../../ui/utils/icons.dart';

class ArchiveCard extends StatelessWidget {
  final ChatListProvider provider;
  final IList<ChatModel> archiveList;

  ArchiveCard({
    super.key,
    required this.provider,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.applicationConstant),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArchiveChatScreen(
                provider: provider,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Insets.applicationConstantSmall,
              right: Insets.applicationConstantSmall,
              top: Insets.applicationConstantLarge,
              bottom: Insets.applicationConstantLarge,
            ),
            child: _archiveContent(context),
          ),
        ),
      ),
    );
  }

  Widget _archiveContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.archive,
                size: IconsSize.extraLarge,
              ),
              const SizedBox(width: Insets.applicationConstantMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Archive'),
                  Text(
                    archiveList.isNotEmpty
                        ? archiveList.length == 1
                            ? archiveList.first.chatTitle
                            : '${archiveList.first.chatTitle}...'
                        : 'Archive is empty',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
