import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/appearance_cubit.dart';
import '../settings_button_foundation.dart';
import 'tags_bottom_sheet/tag_bottom_sheet.dart';

class AppearanceTagAdd extends StatelessWidget {
  const AppearanceTagAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (context) {
          return const TagBottomSheet();
        },
      ),
      iconCodePoint: Icons.tag.codePoint,
      buttonTitle: 'Create new tag',
      buttonDescription: 'Add your tag',
    );
  }
}
