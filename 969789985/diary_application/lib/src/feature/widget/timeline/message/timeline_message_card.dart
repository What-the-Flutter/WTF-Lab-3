import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/theme/theme_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/extension/datetime_extension.dart';
import '../../../../core/util/painter/triangle.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';
import '../../../../core/util/resources/strings.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/theme/theme_cubit.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../../page/chat/chat_page.dart';
import '../../general/custom_dialog.dart';
import '../../general/message/base_image_shower.dart';
import '../../general/message/base_message_content.dart';
import '../../theme/theme_scope.dart';
import '../scope/timeline_scope.dart';

class TimelineMessageCard extends StatelessWidget {
  final MessageModel message;

  TimelineMessageCard({
    super.key,
    required this.message,
  });

  final double _maxWidth = 350.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, tState) {
        return BlocBuilder<TimelineCubit, TimelineState>(
          builder: (context, state) {
            return message.images.isEmpty
                ? Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomPaint(
                              foregroundPainter: Triangle(
                                ThemeScope.of(context).state.messageAlignment ==
                                        BubbleAlignments.start.alignment
                                    ? Color(
                                        ThemeScope.of(context)
                                            .state
                                            .primaryItemColor,
                                      )
                                    : Colors.transparent,
                              ),
                            ),
                            Flexible(
                              child: AnimatedAlign(
                                curve: Curves.fastOutSlowIn,
                                duration: const Duration(milliseconds: 500),
                                alignment: _messageAlignment(context),
                                child: Container(
                                  constraints:
                                      BoxConstraints(maxWidth: _maxWidth),
                                  margin: const EdgeInsets.only(
                                      bottom: Insets.small),
                                  child: Material(
                                    borderRadius: _messageBorders(context),
                                    color: Color(
                                      ThemeScope.of(context)
                                          .state
                                          .primaryItemColor,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        _showPopupAction(context, state);
                                      },
                                      borderRadius: _messageBorders(context),
                                      child: BaseMessageContent(
                                        message: message,
                                        fromChat: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _triangle(context, BubbleAlignments.end),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Spacer(),
                      BaseImageShower(
                        message: message,
                        fromChat: false,
                      ),
                    ],
                  );
          },
        );
      },
    );
  }

  Widget _triangle(BuildContext context, BubbleAlignments alignment) {
    return ThemeScope.of(context).state.messageAlignment == alignment.alignment
        ? CustomPaint(
            foregroundPainter: Triangle(
              Color(ThemeScope.of(context).state.primaryItemColor),
            ),
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: Insets.none,
            height: Insets.none,
          );
  }

  Alignment _messageAlignment(BuildContext context) {
    final alignment = ThemeScope.of(context).state.messageAlignment;

    switch (alignment) {
      case MessageAlignment.start:
        return Alignment.centerLeft;
      case MessageAlignment.center:
        return Alignment.center;
      case MessageAlignment.end:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  BorderRadius _messageBorders(BuildContext context) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        ThemeScope.of(context).state.messageAlignment ==
                BubbleAlignments.start.alignment
            ? 0.0
            : ThemeScope.of(context).state.messageBorderRadius,
      ),
      bottomLeft: Radius.circular(
        ThemeScope.of(context).state.messageBorderRadius,
      ),
      bottomRight: Radius.circular(
        ThemeScope.of(context).state.messageBorderRadius,
      ),
      topRight: Radius.circular(
        ThemeScope.of(context).state.messageAlignment ==
                BubbleAlignments.end.alignment
            ? 0.0
            : ThemeScope.of(context).state.messageBorderRadius,
      ),
    );
  }

  void _showPopupAction(BuildContext context, TimelineState state) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final button = context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(const Offset(0.0, -65.0), ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero) +
              Offset(
                ThemeScope.of(context).state.messageAlignment ==
                        BubbleAlignments.end.alignment
                    ? 1.0
                    : 0.0,
                0.0,
              ),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    await showMenu(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ThemeScope.of(context).state.messageBorderRadius,
        ),
      ),
      color: Color(ThemeScope.of(context).state.primaryColor),
      elevation: 0,
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: _menuButton(
            context,
            'To chat',
            Icons.chat,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    chat: state.chats.firstWhere(
                      (chat) => chat.id == message.parentId,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: _menuButton(
            context,
            'Delete',
            Icons.delete,
            () => TimelineScope.of(context).deleteMessage(message),
          ),
        ),
        PopupMenuItem(
          child: _menuButton(
            context,
            'Resend',
            Icons.repeat_sharp,
            () {},
          ),
        ),
        PopupMenuItem(
          child: _menuButton(
            context,
            'Information',
            Icons.info_rounded,
            () => _showDialog(context, state),
          ),
        ),
      ],
    );
  }

  Widget _menuButton(
    BuildContext context,
    String text,
    IconData icon,
    Callback action,
  ) {
    return Material(
      color: Color(ThemeScope.of(context).state.primaryColor),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.appConstantSmall),
        onTap: action.call,
        child: Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: Insets.medium),
              Text(
                text,
                style: const TextStyle(
                  fontSize: FontsSize.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, TimelineState state) {
    showDialog(
      context: context,
      builder: (context) => _informationDialog(context, state),
    );
  }

  Widget _informationDialog(BuildContext context, TimelineState state) {
    final chat = state.chats.firstWhere(
      (chat) => chat.id == message.parentId,
    );

    return CustomDialog(
      dialogTitle: 'Information',
      dialogDescription: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                IconData(chat.chatIcon, fontFamily: AppIcons.material),
                size: IconsSize.large,
              ),
              const SizedBox(width: Insets.medium),
              Text(
                chat.chatTitle,
                style: const TextStyle(
                  fontSize: FontsSize.large,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.large),
          Text(
            'Current message: ${message.messageText}',
            style: const TextStyle(
              fontSize: FontsSize.normal,
            ),
          ),
          const SizedBox(height: Insets.medium),
          Text(
            'Send date: ${message.sendDate.timeJmFormat()} ${message.sendDate.dateYMMMDFormat()}',
            style: const TextStyle(
              fontSize: FontsSize.normal,
            ),
          ),
        ],
      ),
      completeAction: () => Navigator.pop(context),
      cancelVisible: false,
    );
  }
}
