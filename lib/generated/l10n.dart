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

  /// `Social Manager`
  String get social_manager {
    return Intl.message(
      'Social Manager',
      name: 'social_manager',
      desc: '',
      args: [],
    );
  }

  /// `Tab #`
  String get tab_no {
    return Intl.message(
      'Tab #',
      name: 'tab_no',
      desc: '',
      args: [],
    );
  }

  /// `Save Link`
  String get save_link {
    return Intl.message(
      'Save Link',
      name: 'save_link',
      desc: '',
      args: [],
    );
  }

  /// `The link will appear in save links.`
  String get the_link_will_appear_in_saved_links {
    return Intl.message(
      'The link will appear in save links.',
      name: 'the_link_will_appear_in_saved_links',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get share {
    return Intl.message(
      'share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Open in new tab`
  String get open_in_new_tab {
    return Intl.message(
      'Open in new tab',
      name: 'open_in_new_tab',
      desc: '',
      args: [],
    );
  }

  /// `My Statistics`
  String get my_statistics {
    return Intl.message(
      'My Statistics',
      name: 'my_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Saved Links`
  String get saved_links {
    return Intl.message(
      'Saved Links',
      name: 'saved_links',
      desc: '',
      args: [],
    );
  }

  /// `My Media`
  String get my_media {
    return Intl.message(
      'My Media',
      name: 'my_media',
      desc: '',
      args: [],
    );
  }

  /// `Delete Link`
  String get delete_link {
    return Intl.message(
      'Delete Link',
      name: 'delete_link',
      desc: '',
      args: [],
    );
  }

  /// `Show Preview`
  String get show_preview {
    return Intl.message(
      'Show Preview',
      name: 'show_preview',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Bar Charts`
  String get bar_charts {
    return Intl.message(
      'Bar Charts',
      name: 'bar_charts',
      desc: '',
      args: [],
    );
  }

  /// `Pie Charts`
  String get pie_charts {
    return Intl.message(
      'Pie Charts',
      name: 'pie_charts',
      desc: '',
      args: [],
    );
  }

  /// `Legend`
  String get legend {
    return Intl.message(
      'Legend',
      name: 'legend',
      desc: '',
      args: [],
    );
  }

  /// `Links Opened`
  String get links_opened {
    return Intl.message(
      'Links Opened',
      name: 'links_opened',
      desc: '',
      args: [],
    );
  }

  /// `Links Saved`
  String get links_saved {
    return Intl.message(
      'Links Saved',
      name: 'links_saved',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Phone N.O`
  String get phone_no {
    return Intl.message(
      'Phone N.O',
      name: 'phone_no',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Pelase enter a valid {field}.`
  String invalid_field(Object field) {
    return Intl.message(
      'Pelase enter a valid $field.',
      name: 'invalid_field',
      desc: '',
      args: [field],
    );
  }

  /// `Password again`
  String get password_again {
    return Intl.message(
      'Password again',
      name: 'password_again',
      desc: '',
      args: [],
    );
  }

  /// `Phone N.O must be {length} digits.`
  String phone_number_must_be_length(Object length) {
    return Intl.message(
      'Phone N.O must be $length digits.',
      name: 'phone_number_must_be_length',
      desc: '',
      args: [length],
    );
  }

  /// `{field} must be not less than {length}.`
  String field_must_be_not_less_than_length(Object field, Object length) {
    return Intl.message(
      '$field must be not less than $length.',
      name: 'field_must_be_not_less_than_length',
      desc: '',
      args: [field, length],
    );
  }

  /// `Passwords don't match.`
  String get passwords_dont_match {
    return Intl.message(
      'Passwords don\'t match.',
      name: 'passwords_dont_match',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Credentials`
  String get wrong_credentials {
    return Intl.message(
      'Wrong Credentials',
      name: 'wrong_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connection_error {
    return Intl.message(
      'Connection Error',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `This phone number is already taken`
  String get this_phone_is_already_taken {
    return Intl.message(
      'This phone number is already taken',
      name: 'this_phone_is_already_taken',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {user}!`
  String welcome_user(Object user) {
    return Intl.message(
      'Welcome $user!',
      name: 'welcome_user',
      desc: '',
      args: [user],
    );
  }

  /// `To start your social media journey you have to enable some platforms.`
  String
      get to_start_your_social_media_journey_you_have_to_enable_some_platforms {
    return Intl.message(
      'To start your social media journey you have to enable some platforms.',
      name:
          'to_start_your_social_media_journey_you_have_to_enable_some_platforms',
      desc: '',
      args: [],
    );
  }

  /// `Open Media Settings`
  String get open_settings {
    return Intl.message(
      'Open Media Settings',
      name: 'open_settings',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `You should enable at least {count} service to use the app`
  String you_should_enable_at_least_count_services_to_use_the_app(
      Object count) {
    return Intl.message(
      'You should enable at least $count service to use the app',
      name: 'you_should_enable_at_least_count_services_to_use_the_app',
      desc: '',
      args: [count],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `My History`
  String get my_history {
    return Intl.message(
      'My History',
      name: 'my_history',
      desc: '',
      args: [],
    );
  }

  /// `Visited at`
  String get visited_at {
    return Intl.message(
      'Visited at',
      name: 'visited_at',
      desc: '',
      args: [],
    );
  }

  /// `Saved at`
  String get saved_at {
    return Intl.message(
      'Saved at',
      name: 'saved_at',
      desc: '',
      args: [],
    );
  }

  /// `There is no {media} history yet!`
  String there_is_no_media_history_yet(Object media) {
    return Intl.message(
      'There is no $media history yet!',
      name: 'there_is_no_media_history_yet',
      desc: '',
      args: [media],
    );
  }

  /// `There is no saved {media} link yet!`
  String there_is_no_saved_media_link_yet(Object media) {
    return Intl.message(
      'There is no saved $media link yet!',
      name: 'there_is_no_saved_media_link_yet',
      desc: '',
      args: [media],
    );
  }

  /// `the link is saved successfully!`
  String get the_link_is_saved_successfully {
    return Intl.message(
      'the link is saved successfully!',
      name: 'the_link_is_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Theme:`
  String get theme {
    return Intl.message(
      'Theme:',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Include saved links`
  String get include_saved_links {
    return Intl.message(
      'Include saved links',
      name: 'include_saved_links',
      desc: '',
      args: [],
    );
  }

  /// `The saved links may show certain behaviour of which platform you find more informing.`
  String
      get the_saved_links_may_show_certain_behaviour_of_which_platform_you_find_more_informing {
    return Intl.message(
      'The saved links may show certain behaviour of which platform you find more informing.',
      name:
          'the_saved_links_may_show_certain_behaviour_of_which_platform_you_find_more_informing',
      desc: '',
      args: [],
    );
  }

  /// `Post Scheduling`
  String get post_scheduling {
    return Intl.message(
      'Post Scheduling',
      name: 'post_scheduling',
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
