import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/services/auth_biometrics.dart';
import 'package:my_final_project/ui/screens/main_screen.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';
import 'package:my_final_project/utils/theme/theme_state.dart';

class MainApp extends StatefulWidget {
  final User? user;

  const MainApp({
    super.key,
    required this.user,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool status = false;

  @override
  void initState() {
    super.initState();
    isStatus();
  }

  void isStatus() async {
    final statusAuth = await AuthBiometrics.authenticateUser();
    setState(
      () {
        status = statusAuth;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MenuCubit(),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(user: widget.user),
        ),
        BlocProvider(
          create: (_) => HomeCubit(user: widget.user),
        ),
        BlocProvider(
          create: (_) => EventCubit(user: widget.user),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            title: 'Chat Journal',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: status ? const Menu() : null,
          );
        },
      ),
    );
  }
}
