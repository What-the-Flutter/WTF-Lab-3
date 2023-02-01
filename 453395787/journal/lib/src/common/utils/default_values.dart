import 'package:flutter/material.dart';

import '../../features/security/data/security_repository_api.dart';
import '../features/settings/settings.dart';

abstract class DefaultValues {
  static final FontScaleFactor fontScaleFactor = FontScaleFactor.medium;
  static final MessageAlignment messageAlignment = MessageAlignment.right;
  static final bool isCenterDateBubbleShown = true;
  static final VerifyMethod verifyMethod = VerifyMethod.none;
  static final bool isDarkMode = true;
  static final Color color = Colors.blue;
  static final Locale? locale = null;
}
