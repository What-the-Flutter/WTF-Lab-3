import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/icons.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final Widget? widget;

  ChatCard({Key? key, required this.chat, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final desc = local?.chatDescription ?? '';
    final attach = local?.attach ?? '';

    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIcon(),
          const SizedBox(width: 20),
          Expanded(child: _buildText(context, desc, attach), flex: 1),
          widget ?? _buildTimeText(context),
          const SizedBox(width: 25)
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: circleMessageColor,
            shape: BoxShape.circle,
          ),
          child: Icon(IconMap.data[chat.iconNumber]),
        ),
        if (chat.isPin)
          Positioned(
            right: -5,
            bottom: -1,
            child: Icon(
              Icons.push_pin,
              color: pinIconColor,
            ),
          ),
      ],
    );
  }

  Column _buildText(
    BuildContext context,
    String defaultDescription,
    String attach,
  ) {
    String description;
    if (chat.lastEvent.isEmpty) {
      description = defaultDescription;
    } else {
      final descLength = 18 * countOrientationCoefficient(context);

      final message = chat.lastEvent;
      description = message.isNotEmpty ? fitText(message, descLength) : attach;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chat.title,
          style: textTheme(context).headline4!,
        ),
        Text(
          description.replaceAll('\n', ' '),
          style: textTheme(context).bodyText1!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Text _buildTimeText(BuildContext context) {
    String? time;
    if (chat.lastUpdate.isNotEmpty) {
      final creationTime = chat.lastUpdate;
      time = formatDate(context, creationTime, includeTime: true);
    }
    return Text(
      time ?? '',
      style: textTheme(context).bodyText1!.copyWith(color: Colors.grey),
    );
  }
}
