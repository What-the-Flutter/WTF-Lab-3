import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

abstract class LocaleRepositoryApi {
  Future<Locale?> getLocale();

  Future<void> setLocale(Locale? locale);

  static IList<Locale> get supportedLocales => const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ].lock;

  static IList<String> get localeNames => [
        'english',
        'русский',
      ].lock;
}
