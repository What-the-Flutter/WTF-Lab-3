import 'package:flutter/material.dart';

import 'models/chat.dart';

const Color white = Colors.white;

List<Icon> icons = [
  const Icon(
    Icons.title,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.airplanemode_active,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.fitness_center,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.chair,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.landscape_rounded,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.back_hand,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.dark_mode,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.elderly,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.get_app,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.headphones,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.insert_emoticon_rounded,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.kayaking,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.mail,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.navigation,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.outdoor_grill,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.park,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.question_mark,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.recycling,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.school,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.task,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.unarchive,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.videocam_rounded,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.wb_sunny,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.account_balance,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.balance,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.calendar_month,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.fastfood,
    size: 30,
    color: white,
  ),
  const Icon(
    Icons.handyman,
    size: 30,
    color: white,
  ),
];

List<Chat> chats = <Chat>[
  Chat(
    name: 'Travel',
    key: UniqueKey(),
    icon: icons[1],
  ),
  Chat(
    name: 'Family',
    key: UniqueKey(),
    icon: icons[3],
  ),
  Chat(
    name: 'Sports',
    key: UniqueKey(),
    icon: icons[2],
  )
];
