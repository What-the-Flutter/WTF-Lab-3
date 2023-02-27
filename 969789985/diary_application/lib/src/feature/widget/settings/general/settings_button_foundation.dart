import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';
import '../../../../core/util/typedefs.dart';

class SettingsButtonFoundation extends StatelessWidget {
  final Callback action;
  final int iconCodePoint;
  final String buttonTitle;
  final String buttonDescription;
  final bool isRemovable;

  const SettingsButtonFoundation({
    super.key,
    required this.action,
    required this.iconCodePoint,
    required this.buttonTitle,
    required this.buttonDescription,
    required this.isRemovable,
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
                color: isRemovable ? Colors.red : null,
              ),
              const SizedBox(width: Insets.large),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buttonTitle,
                    style: TextStyle(
                      fontSize: FontsSize.normal,
                      color: isRemovable ? Colors.red : null,
                    ),
                  ),
                  Text(
                    buttonDescription,
                    style: TextStyle(
                      color: isRemovable
                          ? Colors.red
                          : Theme.of(context).hintColor,
                    ),
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
