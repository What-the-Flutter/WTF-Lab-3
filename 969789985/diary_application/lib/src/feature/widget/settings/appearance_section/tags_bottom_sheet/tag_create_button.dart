import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/settings/appearance_cubit.dart';
import '../../../theme/theme_scope.dart';

class TagCreateButton extends StatelessWidget {
  final AppearanceState state;

  const TagCreateButton({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: Color(ThemeScope.of(context).state.primaryItemColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.circle),
      ),
      onPressed: () {
        context.read<AppearanceCubit>().addTag(
              TagModel(
                tagTitle: state.tagText,
                tagIcon: state.selectedIcon,
              ),
            );
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: Insets.large,
          horizontal: Insets.large,
        ),
        child: Text('Create'),
      ),
    );
  }
}
