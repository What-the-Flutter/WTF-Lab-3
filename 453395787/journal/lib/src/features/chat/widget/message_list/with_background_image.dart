import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/cubit/settings_cubit.dart';

class WithBackgroundImage extends StatelessWidget {
  const WithBackgroundImage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return LimitedBox(
          maxHeight: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: state.imagePath == null
                  ? null
                  : DecorationImage(
                      image: Image.file(
                        File(
                          state.imagePath!,
                        ),
                      ).image,
                      fit: BoxFit.cover,
                    ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
