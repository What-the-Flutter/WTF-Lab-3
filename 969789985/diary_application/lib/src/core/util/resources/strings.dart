abstract class AuthSelections {
  static const String noneSecurity = '_none_security';
  static const String withPasscode = '_with_password';
  static const String withFingerprint = '_with_fingerprint';
  static const String withFaceId = '_with_face_id';
  static const String withPasscodeAndBiometric = '_with_passcode_and_biometric';
}

abstract class MessageAlignment {
  static const String start = '_start';
  static const String center = '_center';
  static const String end = '_end';
}

abstract class Strings {
  static const String chatTitleTooltipMessage =
      'Give a short and meaningful title (for example,\nif your chat is about sports events,\ngive it the name "Sport").';

  static const String chatEmptyMessage =
      'The chat is currently empty. You can start running it at any time by simply leaving any message. You can also perform some actions on your messages if you long press on any of them.';

  static const String chatExample = 'Your chat will look like this:';

  static const String deleteChatTitle = 'Chat removing';

  static const String deleteChatDescription =
      'Are you sure you want to delete this chat?';

  static const String deleteSelectedMessagesTitle = 'Removing messages';

  static const deleteSelectedMessagesDescription =
      'Are you sure you want to delete the selected messages?';

  static const String chatInformationTitle = 'Information';

  static const String resendMessage =
      'You must select one or more chats from the list';

  static const String securityInformation =
      'You can set authentication to enter the application. Please note that you can only install one of the suggested options.';

  static const String passcodeInf = 'Please enter your passcode';

  static const String passcodeWarning =
      'Be careful, if you forget or lose your passcode, you will no longer be able to access your data';

  static const String appGitShare = 'https://github.com/flutterwtf/WTF-Lab-3/tree/main/969789985/diary_application';
}
