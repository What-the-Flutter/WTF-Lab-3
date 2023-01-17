import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_repository_api.dart';

class LocaleRepository implements LocaleRepositoryApi {
  static const _localeLanguageCodeKey = 'localeLangCodeKey';
  static const _localeCountryCodeKey = 'localeCountryCodeKey';

  static Locale? _locale;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    var langCode = await prefs.getString(_localeLanguageCodeKey);
    var countryCode = await prefs.getString(_localeCountryCodeKey);

    if (langCode != null) {
      _locale = Locale(langCode, countryCode);
    } else {
      _locale = null;
    }
  }

  @override
  Locale? get locale => _locale;

  @override
  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();

    if (locale == null) {
      _locale = null;
      await prefs.remove(_localeLanguageCodeKey);
      await prefs.remove(_localeCountryCodeKey);
    } else {
      _locale = locale;
      await prefs.setString(_localeLanguageCodeKey, locale.languageCode);
      if (locale.countryCode != null) {
        await prefs.setString(_localeCountryCodeKey, locale.countryCode!);
      }
    }
  }
}
