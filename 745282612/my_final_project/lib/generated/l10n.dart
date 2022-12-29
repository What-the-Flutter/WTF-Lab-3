// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `This is the page where you can track everything about "{rate}"!`
  String title_instruction(String rate) {
    return Intl.message(
      'This is the page where you can track everything about "$rate"!',
      name: 'title_instruction',
      desc: '',
      args: [rate],
    );
  }

  /// `Add your first event to "{rate}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.`
  String body_instruction(String rate) {
    return Intl.message(
      'Add your first event to "$rate" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
      name: 'body_instruction',
      desc: '',
      args: [rate],
    );
  }

  /// `No Events. Click to create one`
  String get no_event {
    return Intl.message(
      'No Events. Click to create one',
      name: 'no_event',
      desc: '',
      args: [],
    );
  }

  /// `Create a new Page`
  String get create_page {
    return Intl.message(
      'Create a new Page',
      name: 'create_page',
      desc: '',
      args: [],
    );
  }

  /// `Questionnaire bot`
  String get questionnaire {
    return Intl.message(
      'Questionnaire bot',
      name: 'questionnaire',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_label {
    return Intl.message(
      'Home',
      name: 'home_label',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily_label {
    return Intl.message(
      'Daily',
      name: 'daily_label',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get timeline_label {
    return Intl.message(
      'Timeline',
      name: 'timeline_label',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore_label {
    return Intl.message(
      'Explore',
      name: 'explore_label',
      desc: '',
      args: [],
    );
  }

  /// `Add new event`
  String get add_new_event {
    return Intl.message(
      'Add new event',
      name: 'add_new_event',
      desc: '',
      args: [],
    );
  }

  /// `If you click on the  camera icon, you can add an image from the camera, if you click on the photo icon, you can add an image from the phone.`
  String get content_add_image {
    return Intl.message(
      'If you click on the  camera icon, you can add an image from the camera, if you click on the photo icon, you can add an image from the phone.',
      name: 'content_add_image',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get title_add_image {
    return Intl.message(
      'Add image',
      name: 'title_add_image',
      desc: '',
      args: [],
    );
  }

  /// `Edit Page`
  String get edit_page {
    return Intl.message(
      'Edit Page',
      name: 'edit_page',
      desc: '',
      args: [],
    );
  }

  /// `Name of the page`
  String get name_of_the_page {
    return Intl.message(
      'Name of the page',
      name: 'name_of_the_page',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Pin/Unpin Page`
  String get pin_unpin {
    return Intl.message(
      'Pin/Unpin Page',
      name: 'pin_unpin',
      desc: '',
      args: [],
    );
  }

  /// `Archive Page`
  String get archive_page {
    return Intl.message(
      'Archive Page',
      name: 'archive_page',
      desc: '',
      args: [],
    );
  }

  /// `Delete Page`
  String get delete_page {
    return Intl.message(
      'Delete Page',
      name: 'delete_page',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  /// `Last Event`
  String get last_event {
    return Intl.message(
      'Last Event',
      name: 'last_event',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
