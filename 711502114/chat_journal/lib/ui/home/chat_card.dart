import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/colors.dart';
import '../../utils/utils.dart';
import 'chat.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.assetsLink,
  }) : super(key: key);

  final Chat chat;
  final String assetsLink;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final desc = local?.chatDescription ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIcon(),
          const SizedBox(width: 20),
          Expanded(
            child: _buildText(desc),
            flex: 1,
          ),
          _buildTimeText(context),
          const SizedBox(width: 25,)
        ],
      ),
    );
  }

  Container _buildIcon() {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: circleMessageColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(assetsLink, color: Colors.white),
    );
  }

  Column _buildText(String desc) {
    String description;
    if (chat.isDescriptionEmpty) {
      description = desc;
    } else {
      description = chat.description.length > 35
          ? '${chat.description.substring(0, 36)}...'
          : chat.description;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chat.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Text _buildTimeText(BuildContext context) {
    String? time;
    if (chat.messages.isNotEmpty) {
      final dateTime = chat.messages.last.dateTime;
      time = formatDate(context, dateTime, includeTime: true);
    }
    return Text(
      time ?? '',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }
}
