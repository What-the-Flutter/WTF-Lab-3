import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/settings/security_cubit.dart';
import '../../../../page/settings/security/security_passcode_page.dart';
import '../../../theme/theme_scope.dart';

class SecuritySetPasscodeButton extends StatelessWidget {
  const SecuritySetPasscodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        return MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Radii.medium,
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SecurityPasscodePage(),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: Insets.large),
            child: Text(
              'Enable passcode',
              style: TextStyle(
                fontSize: FontsSize.large,
              ),
            ),
          ),
          color: Color(ThemeScope.of(context).state.primaryColor),
        );
      },
    );
  }
}
