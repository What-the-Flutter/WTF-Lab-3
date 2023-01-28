import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/theme/theme.dart';

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

  static TextStyle messageText(BuildContext context) {
    return DefaultTextStyle.of(context).style.copyWith(
          color: context.watch<ThemeCubit>().state.isDarkMode
              ? Colors.white
              : Colors.black,
          fontSize: 15,
        );
  }

  static TextStyle messageHighlighted(BuildContext context) {
    return DefaultTextStyle.of(context).style.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 15,
        );
  }

  static TextStyle bodyRed(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.red,
        );
  }
}
