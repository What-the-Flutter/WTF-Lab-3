import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/data/repository/chat_repository.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../../common/utils/text_styles.dart';
import '../../chat/widget/scopes/tags_scope.dart';
import '../../chat/widget/tag_selector/tag_selector.dart';
import '../../chat_overview/widget/chat_item_small.dart';
import '../../text_tags/model/text_tag.dart';
import '../../text_tags/widget/text_tag_multi_selector.dart';
import '../../text_tags/widget/text_tag_multi_selector_scope.dart';
import '../cubit/message_filter_cubit.dart';

part '../widget/tag_selector.dart';

part '../widget/text_tag_selector.dart';

part '../widget/chats_selector.dart';

class MessageFilterView extends StatelessWidget {
  const MessageFilterView({
    super.key,
    required this.cubit,
  });

  final MessageFilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageFilterCubit, MessageFilterState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.SettingsPage.tagItem.i18n(),
                style: TextStyles.defaultMedium(context),
              ),
              _TagSelector(
                selectedTags: state.selectedTags,
                onTagsChanged: cubit.setSelectedTags,
              ),
              _TextTagSelector(
                selectedTextTags: state.selectedTextTags,
                onTextTagsChanged: cubit.setSelectedTextTags,
              ),
              _ChatsSelector(
                selectedChats: state.selectedChats,
                chats: context.read<ChatRepository>().chats.value,
                onSelectedChatsChanged: cubit.setSelectedChats,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: cubit.reset,
                    child: Text(
                      locale.Actions.reset.i18n(),
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: context.pop,
                    child: Text(
                      locale.Actions.apply.i18n(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
