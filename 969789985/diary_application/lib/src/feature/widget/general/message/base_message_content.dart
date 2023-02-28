import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/extension/datetime_extension.dart';
import '../../../../core/util/logger.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../../start_screen.dart';
import '../../main/scope/main_scope.dart';
import '../../theme/theme_scope.dart';
import '../../timeline/scope/timeline_scope.dart';
import 'base_tag_box.dart';

class BaseMessageContent extends StatelessWidget {
  final bool fromChat;
  final MessageModel message;

  const BaseMessageContent({
    super.key,
    required this.message,
    required this.fromChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            child: message.tags.isEmpty
                ? message.messageText.length < 27
                    ? Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HashTagText(
                                text: message.messageText,
                                onTap: (text) => fromChat
                                    ? _onHashtagTap(context, text)
                                    : null,
                                decoratedStyle: TextStyle(
                                  fontSize: ThemeScope.of(context)
                                      .state
                                      .messageFontSize,
                                  color: Colors.blue,
                                ),
                                basicStyle: TextStyle(
                                  fontSize: ThemeScope.of(context)
                                      .state
                                      .messageFontSize,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                              const SizedBox(width: Insets.small),
                              Text(
                                message.sendDate.timeJmFormat(),
                                style:
                                    const TextStyle(fontSize: FontsSize.small),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          HashTagText(
                            text: message.messageText,
                            onTap: (text) =>
                                fromChat ? _onHashtagTap(context, text) : null,
                            decoratedStyle: TextStyle(
                              fontSize:
                                  ThemeScope.of(context).state.messageFontSize,
                              color: Colors.blue,
                            ),
                            basicStyle: TextStyle(
                              fontSize:
                                  ThemeScope.of(context).state.messageFontSize,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ),
                          Text(
                            message.sendDate.timeJmFormat(),
                            style: const TextStyle(
                              fontSize: FontsSize.small,
                            ),
                          ),
                        ],
                      )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      HashTagText(
                        text: '${message.messageText}   ',
                        onTap: (text) =>
                            fromChat ? _onHashtagTap(context, text) : null,
                        decoratedStyle: TextStyle(
                          fontSize:
                              ThemeScope.of(context).state.messageFontSize,
                          color: Colors.blue,
                        ),
                        basicStyle: TextStyle(
                          fontSize:
                              ThemeScope.of(context).state.messageFontSize,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Insets.small),
                        child: BaseTagsBox(message: message),
                      ),
                      Text(
                        message.sendDate.timeJmFormat(),
                        style: const TextStyle(
                          fontSize: FontsSize.small,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _onHashtagTap(BuildContext context, String hashtag) {
    StartScreenScope.of(context).pageIndex = 2;
    StartScreenScope.of(context).fabVisible = false;
    StartScreenScope.of(context).hashtag = hashtag;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StartScreen(),
      ),
    );
  }
}
