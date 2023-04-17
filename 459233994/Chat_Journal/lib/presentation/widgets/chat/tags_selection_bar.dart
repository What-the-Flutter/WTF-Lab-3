import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/chat/chat_cubit.dart';
import '../../screens/chat/chat_state.dart';
import '../app_theme/inherited_theme.dart';

class TagSelectionBar extends StatelessWidget {
  final TextEditingController textEditingController;

  TagSelectionBar({required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: state.isFilledTag == true
              ? Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: ReadContext(context)
                          .read<ChatCubit>()
                          .state
                          .tags
                          ?.length,
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
                )
              : Container(),
        );
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
            color: InheritedAppTheme.of(context)!.themeData.actionColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                tag,
                style: TextStyle(
                  color: InheritedAppTheme.of(context)!.themeData.textColor,
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
