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

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `No entries match the given search query. Please try again`
  String get no_search_body {
    return Intl.message(
      'No entries match the given search query. Please try again',
      name: 'no_search_body',
      desc: '',
      args: [],
    );
  }

  /// `No search result available`
  String get no_search_title {
    return Intl.message(
      'No search result available',
      name: 'no_search_title',
      desc: '',
      args: [],
    );
  }

  /// `Select the page you want to migrate the selected event to!`
  String get event_modal_title {
    return Intl.message(
      'Select the page you want to migrate the selected event to!',
      name: 'event_modal_title',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app`
  String get exit_the_app {
    return Intl.message(
      'Exit the app',
      name: 'exit_the_app',
      desc: '',
      args: [],
    );
  }

  /// `Add new section`
  String get add_section {
    return Intl.message(
      'Add new section',
      name: 'add_section',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting_title {
    return Intl.message(
      'Settings',
      name: 'setting_title',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Change theme`
  String get change_theme {
    return Intl.message(
      'Change theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Change font size`
  String get cnange_font_size {
    return Intl.message(
      'Change font size',
      name: 'cnange_font_size',
      desc: '',
      args: [],
    );
  }

  /// `Reset setting`
  String get reset_setting {
    return Intl.message(
      'Reset setting',
      name: 'reset_setting',
      desc: '',
      args: [],
    );
  }

  /// `Choose background image`
  String get choose_image {
    return Intl.message(
      'Choose background image',
      name: 'choose_image',
      desc: '',
      args: [],
    );
  }

  /// `Share app`
  String get share_app {
    return Intl.message(
      'Share app',
      name: 'share_app',
      desc: '',
      args: [],
    );
  }

  /// `Change bubble alignment`
  String get change_bubble_alignment {
    return Intl.message(
      'Change bubble alignment',
      name: 'change_bubble_alignment',
      desc: '',
      args: [],
    );
  }

  /// `Change data bubble alignment`
  String get change_date_bubble {
    return Intl.message(
      'Change data bubble alignment',
      name: 'change_date_bubble',
      desc: '',
      args: [],
    );
  }

  /// `Your timeline is empty!`
  String get timeline_empty {
    return Intl.message(
      'Your timeline is empty!',
      name: 'timeline_empty',
      desc: '',
      args: [],
    );
  }

  /// `There are no events to be displayed on your timeline, or you have filtered out all your pages in the filtermenu.`
  String get timeline_empty_info {
    return Intl.message(
      'There are no events to be displayed on your timeline, or you have filtered out all your pages in the filtermenu.',
      name: 'timeline_empty_info',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filter {
    return Intl.message(
      'Filters',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select a {rate} you want to include to the filter. All {rate} are included by default.`
  String filter_info(String rate) {
    return Intl.message(
      'Tap to select a $rate you want to include to the filter. All $rate are included by default.',
      name: 'filter_info',
      desc: '',
      args: [rate],
    );
  }

  /// `Jump to date`
  String get jump_to_date {
    return Intl.message(
      'Jump to date',
      name: 'jump_to_date',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Only picture`
  String get picture {
    return Intl.message(
      'Only picture',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `Delete element!`
  String get delete_element {
    return Intl.message(
      'Delete element!',
      name: 'delete_element',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Enter Event`
  String get enter_event {
    return Intl.message(
      'Enter Event',
      name: 'enter_event',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_title {
    return Intl.message(
      'Home',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily_title {
    return Intl.message(
      'Daily',
      name: 'daily_title',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get timeline_title {
    return Intl.message(
      'Timeline',
      name: 'timeline_title',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore_title {
    return Intl.message(
      'Explore',
      name: 'explore_title',
      desc: '',
      args: [],
    );
  }

  /// `Small/Medium/Large`
  String get font_size {
    return Intl.message(
      'Small/Medium/Large',
      name: 'font_size',
      desc: '',
      args: [],
    );
  }

  /// `Left/Right`
  String get bubble_alignment {
    return Intl.message(
      'Left/Right',
      name: 'bubble_alignment',
      desc: '',
      args: [],
    );
  }

  /// `Left/Center`
  String get date_bubble {
    return Intl.message(
      'Left/Center',
      name: 'date_bubble',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pages {
    return Intl.message(
      'Pages',
      name: 'pages',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Labels`
  String get labels {
    return Intl.message(
      'Labels',
      name: 'labels',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
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
