import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_repository_api.dart';

class LocaleRepository implements LocaleRepositoryApi {
  static const _localeLanguageCodeKey = 'localeLangCodeKey';
  static const _localeCountryCodeKey = 'localeCountryCodeKey';

  @override
  Future<Locale?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    var langCode = await prefs.getString(_localeLanguageCodeKey);
    var countryCode = await prefs.getString(_localeCountryCodeKey);

    if (langCode != null) {
      return Locale(langCode, countryCode);
    } else {
      return null;
    }
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      prefs.remove(_localeLanguageCodeKey);
      prefs.remove(_localeCountryCodeKey);
    } else {
      prefs.setString(_localeLanguageCodeKey, locale.languageCode);
      if (locale.countryCode != null) {
        prefs.setString(_localeCountryCodeKey, locale.countryCode!);
      }
    }
  }
}
