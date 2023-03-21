import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../timeline/filter/filter_chatter/filter_chatter_card.dart';

class SummaryChatsBottomSheet extends StatelessWidget {
  final IList<ChatModel> chats;

  const SummaryChatsBottomSheet({
    super.key,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: Container(
            height: 500.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.appConstant),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.extraLarge),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return FilterChatterCard(chat: chats[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
