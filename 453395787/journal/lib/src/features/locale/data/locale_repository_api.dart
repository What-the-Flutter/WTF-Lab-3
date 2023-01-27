import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

abstract class LocaleRepositoryApi {
  static IList<Locale> get supportedLocales => const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ].lock;

  static IList<String> get localeNames => const [
        'English',
        'Русский',
      ].lock;

  Locale? get locale;

  Future<void> setLocale(Locale? locale);

  Future<void> resetToDefault();
}
