import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../timeline/scope/timeline_scope.dart';

class SummaryChatsCleanerCard extends StatelessWidget {
  final ChatModel chat;

  const SummaryChatsCleanerCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, tState) {
        return BlocBuilder<TimelineCubit, TimelineState>(
          builder: (_, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Radii.circle),
                      color: Color(tState.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Insets.appConstantMedium,
                        horizontal: Insets.appConstantMedium,
                      ),
                      child: Text(chat.chatTitle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: Insets.extraLarge,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(Radii.circle),
                      color: Colors.red.shade400,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(Radii.circle),
                        onTap: () {
                          TimelineScope.of(context).updateSelectableChats(
                            chat.id,
                          );
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
