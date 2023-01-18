import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/chat.dart';
import '../../theme/colors.dart';
import '../../utils/utils.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final desc = local?.chatDescription ?? '';
    final attach = local?.attach ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIcon(),
          const SizedBox(width: 20),
          Expanded(
            child: _buildText(desc, attach),
            flex: 1,
          ),
          _buildTimeText(context),
          const SizedBox(
            width: 25,
          )
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
      child: SvgPicture.asset(chat.assetsLink, color: Colors.white),
    );
  }

  Column _buildText(String defaultDescription, String attach) {
    String description;
    if (chat.events.isEmpty) {
      description = defaultDescription;
    } else {
      final message = chat.events.last.message;
      description = message.isNotEmpty ? _fitText(message, 30) : attach;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chat.title,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          description,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }

  String _fitText(String message, int maxSymbols) {
    if (message.length <= maxSymbols) {
      return message;
    }

    return '${message.substring(0, maxSymbols - 1)}...';
  }

  Text _buildTimeText(BuildContext context) {
    String? time;
    if (chat.events.isNotEmpty) {
      final dateTime = chat.events.last.dateTime;
      time = formatDate(context, dateTime, includeTime: true);
    }
    return Text(
      time ?? '',
      style: const TextStyle(color: Colors.grey, fontSize: 16),
    );
  }
}
