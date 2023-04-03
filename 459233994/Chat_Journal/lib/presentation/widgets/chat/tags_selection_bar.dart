import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/chat/chat_cubit.dart';
import '../../screens/chat/chat_state.dart';
import '../app_theme/app_theme_cubit.dart';

class TagSelectionBar extends StatelessWidget {
  final TextEditingController textEditingController;

  TagSelectionBar({required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.isFilledTag == true) {
          return Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    ReadContext(context).read<ChatCubit>().state.tags?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _tagBubble(
                    context,
                    ReadContext(context)
                        .read<ChatCubit>()
                        .state
                        .tags![index]
                        .name,
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _tagBubble(BuildContext context, String tag) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .actionColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                tag,
                style: TextStyle(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .textColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          tag = tag.replaceAll('#', '');
          textEditingController.text += '$tag';
          textEditingController.selection = TextSelection.collapsed(
              offset: textEditingController.text.length);
        },
      ),
    );
  }
}
