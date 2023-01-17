import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

import 'features/locale/cubit/locale_cubit.dart';
import 'features/locale/data/locale_repository_api.dart';
import 'features/theme/theme.dart';
import 'routes.dart';

class JournalApp extends StatelessWidget {
  const JournalApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/lang/'];

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              title: 'Journal',
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: state.color,
                brightness:
                    state.isDarkMode ? Brightness.dark : Brightness.light,
              ),
              locale: localeState.mapOrNull(
                custom: (custom) => custom.locale,
              ),
              routerConfig: router,
              localizationsDelegates: _localizationDelegates,
              supportedLocales: LocaleRepositoryApi.supportedLocales,
              localeResolutionCallback: _localeResolution,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ];

  Locale? _localeResolution(Locale? locale, Iterable<Locale> supportedLocales) {
    return supportedLocales.contains(locale)
        ? locale
        : const Locale('en', 'US');
  }
}
