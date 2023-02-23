import 'package:flutter/material.dart';

import '../../../../core/util/typedefs.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';

class SettingsButtonFoundation extends StatelessWidget {
  final Callback action;
  final int iconCodePoint;
  final String buttonTitle;
  final String buttonDescription;

  const SettingsButtonFoundation({
    super.key,
    required this.action,
    required this.iconCodePoint,
    required this.buttonTitle,
    required this.buttonDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.medium,
        right: Insets.medium,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.large),
        ),
        onPressed: action.call,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Insets.large,
            bottom: Insets.large,
            right: Insets.medium,
          ),
          child: Row(
            children: [
              Icon(
                IconData(
                  iconCodePoint,
                  fontFamily: AppIcons.material,
                ),
                size: IconsSize.extraLarge,
              ),
              const SizedBox(width: Insets.large),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buttonTitle,
                    style: const TextStyle(fontSize: FontsSize.normal),
                  ),
                  Text(
                    buttonDescription,
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
