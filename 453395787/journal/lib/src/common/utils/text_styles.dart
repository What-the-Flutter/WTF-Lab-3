import 'package:flutter/material.dart';

abstract class TextStyles {
  static TextStyle defaultStyle(BuildContext context) {
    return DefaultTextStyle.of(context).style;
  }

  static TextStyle defaultBold(BuildContext context) {
    return DefaultTextStyle.of(context).style.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle defaultMedium(BuildContext context) {
    return DefaultTextStyle.of(context).style.copyWith(
          fontSize: 18,
        );
  }

  static TextStyle defaultGrey(BuildContext context) {
    return DefaultTextStyle.of(context).style.copyWith(
          color: Colors.grey,
        );
  }

  static TextStyle bodyRed(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.red,
        );
  }
}
