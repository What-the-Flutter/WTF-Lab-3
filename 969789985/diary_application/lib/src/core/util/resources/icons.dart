import 'package:flutter/material.dart';

abstract class IconsSize {
  static const double small = 12.0;
  static const double standard = 24.0;
  static const double large = 36.0;
  static const double extraLarge = 48.0;
  static const double superExtraLarge = 64.0;
}

final possibleIcons = <int>[
  Icons.chat.codePoint,
  Icons.add.codePoint,
  Icons.ac_unit_outlined.codePoint,
  Icons.access_alarm.codePoint,
  Icons.music_note.codePoint,
  Icons.phone.codePoint,
  Icons.photo_camera_back.codePoint,
  Icons.add_alert_outlined.codePoint,
  Icons.android.codePoint,
  Icons.apple.codePoint,
  Icons.accessible.codePoint,
  Icons.note_outlined.codePoint,
  Icons.access_time_outlined.codePoint,
  Icons.account_balance.codePoint,
  Icons.fastfood.codePoint,
  Icons.abc_sharp.codePoint,
  Icons.account_box.codePoint,
  Icons.account_balance_wallet.codePoint,
  Icons.ad_units.codePoint,
  Icons.add_location.codePoint,
  Icons.adjust.codePoint,
  Icons.airline_seat_individual_suite.codePoint,
  Icons.airplanemode_active.codePoint,
  Icons.alternate_email.codePoint,
  Icons.sports_baseball_outlined.codePoint,
  Icons.event.codePoint,
  Icons.auto_awesome.codePoint,
  Icons.email.codePoint,
  Icons.fingerprint.codePoint,
  Icons.holiday_village.codePoint,
  Icons.language.codePoint,
  Icons.note.codePoint,
  Icons.add_call.codePoint,
  Icons.key.codePoint,
  Icons.laptop.codePoint,
  Icons.account_box_outlined.codePoint,
  Icons.help.codePoint,
  Icons.tag.codePoint,
  Icons.map.codePoint,
  Icons.functions.codePoint,
];

abstract class AppIcons {
  static const String material = 'MaterialIcons';

  static IconData deleteIcon = IconData(
    Icons.delete.codePoint,
    fontFamily: material,
  );

  static IconData editIcon = IconData(
    Icons.edit.codePoint,
    fontFamily: material,
  );
}
