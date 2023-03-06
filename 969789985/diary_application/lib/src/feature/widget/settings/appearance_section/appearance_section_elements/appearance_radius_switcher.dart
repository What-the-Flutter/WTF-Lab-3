import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';

class AppearanceRadiusSwitcher extends StatelessWidget {
  const AppearanceRadiusSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: Insets.large,
            right: Insets.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '  Message border radius',
                style: TextStyle(
                  fontSize: FontsSize.normal,
                ),
              ),
              const SizedBox(height: Insets.medium),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: state.messageBorderRadius,
                      min: 0.0,
                      max: 50.0,
                      divisions: 50,
                      thumbColor: Color(state.primaryColor),
                      activeColor: Color(state.primaryColor),
                      onChanged: (value) =>
                      ThemeScope.of(context).messageBorderRadius = value,
                    ),
                  ),
                  const SizedBox(width: Insets.medium),
                  Text('${state.messageBorderRadius.toInt()}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
