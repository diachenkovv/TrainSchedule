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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ukrainian Railways Train Schedule`
  String get title {
    return Intl.message(
      'Ukrainian Railways Train Schedule',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Direction`
  String get tab_direction {
    return Intl.message('Direction', name: 'tab_direction', desc: '', args: []);
  }

  /// `Board`
  String get tab_board {
    return Intl.message('Board', name: 'tab_board', desc: '', args: []);
  }

  /// `Train Number`
  String get tab_train_number {
    return Intl.message(
      'Train Number',
      name: 'tab_train_number',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Ukrainian`
  String get language_uk {
    return Intl.message('Ukrainian', name: 'language_uk', desc: '', args: []);
  }

  /// `English`
  String get language_en {
    return Intl.message('English', name: 'language_en', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `For developers`
  String get developer {
    return Intl.message(
      'For developers',
      name: 'developer',
      desc: '',
      args: [],
    );
  }

  /// `Use mock data`
  String get use_mock_data {
    return Intl.message(
      'Use mock data',
      name: 'use_mock_data',
      desc: '',
      args: [],
    );
  }

  /// `Instead of real data from Ukrainian Railways`
  String get use_mock_data_subtitle {
    return Intl.message(
      'Instead of real data from Ukrainian Railways',
      name: 'use_mock_data_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About app`
  String get about {
    return Intl.message('About app', name: 'about', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Enter train number`
  String get train_number_hint {
    return Intl.message(
      'Enter train number',
      name: 'train_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `Direction`
  String get direction {
    return Intl.message('Direction', name: 'direction', desc: '', args: []);
  }

  /// `Board`
  String get board {
    return Intl.message('Board', name: 'board', desc: '', args: []);
  }

  /// `Train number`
  String get train_number {
    return Intl.message(
      'Train number',
      name: 'train_number',
      desc: '',
      args: [],
    );
  }

  /// `Train schedule app for Ukrainian Railways.`
  String get app_info {
    return Intl.message(
      'Train schedule app for Ukrainian Railways.',
      name: 'app_info',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get themeModeLight {
    return Intl.message(
      'Light theme',
      name: 'themeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `Always use light theme`
  String get themeModeLightDesc {
    return Intl.message(
      'Always use light theme',
      name: 'themeModeLightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get themeModeDark {
    return Intl.message(
      'Dark theme',
      name: 'themeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `Always use dark theme`
  String get themeModeDarkDesc {
    return Intl.message(
      'Always use dark theme',
      name: 'themeModeDarkDesc',
      desc: '',
      args: [],
    );
  }

  /// `System theme`
  String get themeModeSystem {
    return Intl.message(
      'System theme',
      name: 'themeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Follow system settings`
  String get themeModeSystemDesc {
    return Intl.message(
      'Follow system settings',
      name: 'themeModeSystemDesc',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Flutter`
  String get flutter {
    return Intl.message('Flutter', name: 'flutter', desc: '', args: []);
  }

  /// `Dart`
  String get dart {
    return Intl.message('Dart', name: 'dart', desc: '', args: []);
  }

  /// `Enter text`
  String get textfield_hint {
    return Intl.message(
      'Enter text',
      name: 'textfield_hint',
      desc: '',
      args: [],
    );
  }

  /// `Select an option`
  String get dropdown_hint {
    return Intl.message(
      'Select an option',
      name: 'dropdown_hint',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get datepicker_hint {
    return Intl.message(
      'Select date',
      name: 'datepicker_hint',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get button_ok {
    return Intl.message('OK', name: 'button_ok', desc: '', args: []);
  }

  /// `Apply`
  String get button_apply {
    return Intl.message('Apply', name: 'button_apply', desc: '', args: []);
  }

  /// `Close`
  String get button_close {
    return Intl.message('Close', name: 'button_close', desc: '', args: []);
  }

  /// `Departure station`
  String get from_station {
    return Intl.message(
      'Departure station',
      name: 'from_station',
      desc: '',
      args: [],
    );
  }

  /// `Arrival station`
  String get to_station {
    return Intl.message(
      'Arrival station',
      name: 'to_station',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Train type`
  String get train_type {
    return Intl.message('Train type', name: 'train_type', desc: '', args: []);
  }

  /// `All`
  String get train_type_all {
    return Intl.message('All', name: 'train_type_all', desc: '', args: []);
  }

  /// `Intercity`
  String get train_type_intercity {
    return Intl.message(
      'Intercity',
      name: 'train_type_intercity',
      desc: '',
      args: [],
    );
  }

  /// `Night Express`
  String get train_type_night {
    return Intl.message(
      'Night Express',
      name: 'train_type_night',
      desc: '',
      args: [],
    );
  }

  /// `Regional`
  String get train_type_regional {
    return Intl.message(
      'Regional',
      name: 'train_type_regional',
      desc: '',
      args: [],
    );
  }

  /// `Suburban`
  String get train_type_suburban {
    return Intl.message(
      'Suburban',
      name: 'train_type_suburban',
      desc: '',
      args: [],
    );
  }

  /// `Find trains`
  String get find_trains {
    return Intl.message('Find trains', name: 'find_trains', desc: '', args: []);
  }

  /// `Station`
  String get train_table_station {
    return Intl.message(
      'Station',
      name: 'train_table_station',
      desc: '',
      args: [],
    );
  }

  /// `Arr.`
  String get train_table_arrival {
    return Intl.message(
      'Arr.',
      name: 'train_table_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Dep.`
  String get train_table_departure {
    return Intl.message(
      'Dep.',
      name: 'train_table_departure',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get train_table_stop {
    return Intl.message('Stop', name: 'train_table_stop', desc: '', args: []);
  }

  /// `Platform`
  String get train_table_platform {
    return Intl.message(
      'Platform',
      name: 'train_table_platform',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get train_table_route {
    return Intl.message('Route', name: 'train_table_route', desc: '', args: []);
  }

  /// `Train`
  String get train_table_train {
    return Intl.message('Train', name: 'train_table_train', desc: '', args: []);
  }

  /// `Direction`
  String get schedule_table_direction {
    return Intl.message(
      'Direction',
      name: 'schedule_table_direction',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get schedule_table_time {
    return Intl.message(
      'Time',
      name: 'schedule_table_time',
      desc: '',
      args: [],
    );
  }

  /// `Platform`
  String get schedule_table_platform {
    return Intl.message(
      'Platform',
      name: 'schedule_table_platform',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get schedule_table_status {
    return Intl.message(
      'Status',
      name: 'schedule_table_status',
      desc: '',
      args: [],
    );
  }

  /// `Dep.`
  String get schedule_table_departure {
    return Intl.message(
      'Dep.',
      name: 'schedule_table_departure',
      desc: '',
      args: [],
    );
  }

  /// `Arr.`
  String get schedule_table_arrival {
    return Intl.message(
      'Arr.',
      name: 'schedule_table_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Enter train number`
  String get error_enter_train_number {
    return Intl.message(
      'Enter train number',
      name: 'error_enter_train_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter train number and press 'Find trains'`
  String get empty_train_search {
    return Intl.message(
      'Enter train number and press \'Find trains\'',
      name: 'empty_train_search',
      desc: '',
      args: [],
    );
  }

  /// `Select a station`
  String get error_select_station {
    return Intl.message(
      'Select a station',
      name: 'error_select_station',
      desc: '',
      args: [],
    );
  }

  /// `Select a station and press 'Show schedule'`
  String get empty_schedule_search {
    return Intl.message(
      'Select a station and press \'Show schedule\'',
      name: 'empty_schedule_search',
      desc: '',
      args: [],
    );
  }

  /// `Departure station`
  String get direction_table_from {
    return Intl.message(
      'Departure station',
      name: 'direction_table_from',
      desc: '',
      args: [],
    );
  }

  /// `Arrival station`
  String get direction_table_to {
    return Intl.message(
      'Arrival station',
      name: 'direction_table_to',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get direction_table_date {
    return Intl.message(
      'Date',
      name: 'direction_table_date',
      desc: '',
      args: [],
    );
  }

  /// `Train type`
  String get direction_table_type {
    return Intl.message(
      'Train type',
      name: 'direction_table_type',
      desc: '',
      args: [],
    );
  }

  /// `Select departure and arrival stations`
  String get error_select_stations {
    return Intl.message(
      'Select departure and arrival stations',
      name: 'error_select_stations',
      desc: '',
      args: [],
    );
  }

  /// `Departure and arrival stations cannot be the same`
  String get error_same_stations {
    return Intl.message(
      'Departure and arrival stations cannot be the same',
      name: 'error_same_stations',
      desc: '',
      args: [],
    );
  }

  /// `Select stations and press 'Find trains'`
  String get empty_direction_search {
    return Intl.message(
      'Select stations and press \'Find trains\'',
      name: 'empty_direction_search',
      desc: '',
      args: [],
    );
  }

  /// `Schedule type`
  String get schedule_type {
    return Intl.message(
      'Schedule type',
      name: 'schedule_type',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get schedule_type_departure {
    return Intl.message(
      'Departure',
      name: 'schedule_type_departure',
      desc: '',
      args: [],
    );
  }

  /// `Arrival`
  String get schedule_type_arrival {
    return Intl.message(
      'Arrival',
      name: 'schedule_type_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get train_type_fast {
    return Intl.message('Fast', name: 'train_type_fast', desc: '', args: []);
  }

  /// `Passenger`
  String get train_type_passenger {
    return Intl.message(
      'Passenger',
      name: 'train_type_passenger',
      desc: '',
      args: [],
    );
  }

  /// `Express`
  String get train_type_express {
    return Intl.message(
      'Express',
      name: 'train_type_express',
      desc: '',
      args: [],
    );
  }

  /// `Intercity+`
  String get train_type_intercity_plus {
    return Intl.message(
      'Intercity+',
      name: 'train_type_intercity_plus',
      desc: '',
      args: [],
    );
  }

  /// `On time`
  String get status_on_time {
    return Intl.message('On time', name: 'status_on_time', desc: '', args: []);
  }

  /// `Delayed`
  String get status_delayed {
    return Intl.message('Delayed', name: 'status_delayed', desc: '', args: []);
  }

  /// `Departed`
  String get status_departed {
    return Intl.message(
      'Departed',
      name: 'status_departed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get status_cancelled {
    return Intl.message(
      'Cancelled',
      name: 'status_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Full route:`
  String get full_route {
    return Intl.message('Full route:', name: 'full_route', desc: '', args: []);
  }

  /// `From`
  String get from_price {
    return Intl.message('From', name: 'from_price', desc: '', args: []);
  }

  /// `Seats`
  String get seats {
    return Intl.message('Seats', name: 'seats', desc: '', args: []);
  }

  /// `h`
  String get duration_hour {
    return Intl.message('h', name: 'duration_hour', desc: '', args: []);
  }

  /// `min`
  String get duration_minute {
    return Intl.message('min', name: 'duration_minute', desc: '', args: []);
  }

  /// `Swap stations`
  String get swap_stations {
    return Intl.message(
      'Swap stations',
      name: 'swap_stations',
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
      Locale.fromSubtags(languageCode: 'uk'),
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
