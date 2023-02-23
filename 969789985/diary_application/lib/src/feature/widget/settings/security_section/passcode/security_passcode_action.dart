import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/settings/security_cubit.dart';
import '../../../theme/theme_scope.dart';

class SecurityPasscodeAction extends StatelessWidget {
  const SecurityPasscodeAction({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 0,
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).indicatorColor,
      ),
      color: Color(ThemeScope.of(context).state.primaryItemColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Radii.appConstant,
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: BlocBuilder<SecurityCubit, SecurityState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(
                    state.withBiometric
                        ? 'Without biometric'
                        : 'With biometric',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: FontsSize.standard + 2,
                    ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: state.withBiometric,
                    onChanged: (value) {
                      context
                          .read<SecurityCubit>()
                          .updateBiometricSwitcher(value);
                    },
                    activeColor: Colors.lightGreen,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
