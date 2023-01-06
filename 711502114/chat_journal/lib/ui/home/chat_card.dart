import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/colors.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 20),
          _buildText(),
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

  Column _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chat.title,
          style: const TextStyle(
            fontFamily: 'Bold',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          chat.description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
