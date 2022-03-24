// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(field, length) =>
      "${field} must be not less than ${length}.";

  static String m1(field) => "Pelase enter a valid ${field}.";

  static String m2(length) => "Phone N.O must be ${length} digits.";

  static String m3(media) => "There is no ${media} history yet!";

  static String m4(media) => "There is no saved ${media} link yet!";

  static String m5(user) => "Welcome ${user}!";

  static String m6(count) =>
      "You should enable at least ${count} service to use the app";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bar_charts": MessageLookupByLibrary.simpleMessage("Bar Charts"),
        "connection_error":
            MessageLookupByLibrary.simpleMessage("Connection Error"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "delete_link": MessageLookupByLibrary.simpleMessage("Delete Link"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "field_must_be_not_less_than_length": m0,
        "include_saved_links":
            MessageLookupByLibrary.simpleMessage("Include saved links"),
        "invalid_field": m1,
        "legend": MessageLookupByLibrary.simpleMessage("Legend"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "links_opened": MessageLookupByLibrary.simpleMessage("Links Opened"),
        "links_saved": MessageLookupByLibrary.simpleMessage("Links Saved"),
        "log_out": MessageLookupByLibrary.simpleMessage("Logout"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "my_history": MessageLookupByLibrary.simpleMessage("My History"),
        "my_media": MessageLookupByLibrary.simpleMessage("My Media"),
        "my_statistics": MessageLookupByLibrary.simpleMessage("My Statistics"),
        "open_in_new_tab":
            MessageLookupByLibrary.simpleMessage("Open in new tab"),
        "open_settings":
            MessageLookupByLibrary.simpleMessage("Open Media Settings"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_again":
            MessageLookupByLibrary.simpleMessage("Password again"),
        "passwords_dont_match":
            MessageLookupByLibrary.simpleMessage("Passwords don\'t match."),
        "phone_no": MessageLookupByLibrary.simpleMessage("Phone N.O"),
        "phone_number_must_be_length": m2,
        "pie_charts": MessageLookupByLibrary.simpleMessage("Pie Charts"),
        "post_scheduling":
            MessageLookupByLibrary.simpleMessage("Post Scheduling"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_link": MessageLookupByLibrary.simpleMessage("Save Link"),
        "saved_at": MessageLookupByLibrary.simpleMessage("Saved at"),
        "saved_links": MessageLookupByLibrary.simpleMessage("Saved Links"),
        "share": MessageLookupByLibrary.simpleMessage("share"),
        "show_preview": MessageLookupByLibrary.simpleMessage("Show Preview"),
        "signup": MessageLookupByLibrary.simpleMessage("Sign up"),
        "social_manager":
            MessageLookupByLibrary.simpleMessage("Social Manager"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "tab_no": MessageLookupByLibrary.simpleMessage("Tab #"),
        "the_link_is_saved_successfully": MessageLookupByLibrary.simpleMessage(
            "the link is saved successfully!"),
        "the_link_will_appear_in_saved_links":
            MessageLookupByLibrary.simpleMessage(
                "The link will appear in save links."),
        "the_saved_links_may_show_certain_behaviour_of_which_platform_you_find_more_informing":
            MessageLookupByLibrary.simpleMessage(
                "The saved links may show certain behaviour of which platform you find more informing."),
        "theme": MessageLookupByLibrary.simpleMessage("Theme:"),
        "there_is_no_media_history_yet": m3,
        "there_is_no_saved_media_link_yet": m4,
        "this_phone_is_already_taken": MessageLookupByLibrary.simpleMessage(
            "This phone number is already taken"),
        "to_start_your_social_media_journey_you_have_to_enable_some_platforms":
            MessageLookupByLibrary.simpleMessage(
                "To start your social media journey you have to enable some platforms."),
        "user_name": MessageLookupByLibrary.simpleMessage("User Name"),
        "visited_at": MessageLookupByLibrary.simpleMessage("Visited at"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcome_user": m5,
        "wrong_credentials":
            MessageLookupByLibrary.simpleMessage("Wrong Credentials"),
        "you_should_enable_at_least_count_services_to_use_the_app": m6
      };
}
