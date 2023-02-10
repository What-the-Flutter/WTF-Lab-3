import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/database/chat_database.dart';
import '../../../../../../common/models/tag_model.dart';
import '../../../../../../common/themes/widget/theme_scope.dart';
import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/appearance_cubit.dart';

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
        RepositoryProvider.of<ChatDatabase>(context).addTag(
            TagModel(tagIcon: state.selectedIcon, tagTitle: state.tagText));
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
