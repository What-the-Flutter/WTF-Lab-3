import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/services/auth_biometrics.dart';
import 'package:my_final_project/ui/screens/main_screen.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
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
    return BlocBuilder<SettingCubit, SettingState>(
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
          home: status
              ? const Menu()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
