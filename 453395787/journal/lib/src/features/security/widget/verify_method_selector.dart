import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../../common/utils/text_styles.dart';
import '../data/security_repository_api.dart';
import '../utils/verify_method_enum.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({
    super.key,
    required this.securityRepository,
  });

  final SecurityRepositoryApi securityRepository;

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  late bool _mustVerifyUserThenAppStarted;

  @override
  void initState() {
    super.initState();
    _mustVerifyUserThenAppStarted =
        widget.securityRepository.verifyMethod != VerifyMethod.none;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
        vertical: Insets.large,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            locale.SettingsPage.securityPageTitle.i18n(),
            style: TextStyles.defaultMedium(context),
          ),
          CheckboxListTile(
            title: Text(
              locale.Actions.yes.i18n(),
            ),
            value: _mustVerifyUserThenAppStarted,
            onChanged: (isChecked) async {
              widget.securityRepository.setVerifyMethod(
                VerifyMethod.fingerprint,
              );
              setState(() {
                _mustVerifyUserThenAppStarted = true;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              locale.Actions.no.i18n(),
            ),
            value: !_mustVerifyUserThenAppStarted,
            onChanged: (isChecked) async {
              widget.securityRepository.setVerifyMethod(
                VerifyMethod.none,
              );
              setState(() {
                _mustVerifyUserThenAppStarted = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
