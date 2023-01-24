import 'package:flutter/material.dart';

import '../../features/security/data/security_repository_api.dart';
import '../../features/settings/data/settings_repository_api.dart';

abstract class DefaultValues {
  static final FontSize fontSize = FontSize.medium;
  static final MessageAlignment messageAlignment = MessageAlignment.right;
  static final bool isCenterDateBubbleShown = true;
  static final VerifyMethod verifyMethod = VerifyMethod.none;
  static final bool isDarkMode = true;
  static final Color color = Colors.blue;
  static final Locale? locale = null;
}
