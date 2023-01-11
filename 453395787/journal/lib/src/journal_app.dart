import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/theme/theme.dart';
import 'routes.dart';

class JournalApp extends StatelessWidget {
  const JournalApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Journal',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: state.color,
            brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
