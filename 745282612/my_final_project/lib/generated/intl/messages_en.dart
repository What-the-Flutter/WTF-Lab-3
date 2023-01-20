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

  static String m0(rate) =>
      "Add your first event to \"${rate}\" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.";

  static String m1(rate) =>
      "This is the page where you can track everything about \"${rate}\"!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "add_new_event": MessageLookupByLibrary.simpleMessage("Add new event"),
        "add_section": MessageLookupByLibrary.simpleMessage("Add new section"),
        "archive_page": MessageLookupByLibrary.simpleMessage("Archive Page"),
        "body_instruction": m0,
        "change_theme": MessageLookupByLibrary.simpleMessage("Change theme"),
        "cnange_font_size":
            MessageLookupByLibrary.simpleMessage("Change font size"),
        "content_add_image": MessageLookupByLibrary.simpleMessage(
            "If you click on the  camera icon, you can add an image from the camera, if you click on the photo icon, you can add an image from the phone."),
        "create_page":
            MessageLookupByLibrary.simpleMessage("Create a new Page"),
        "created": MessageLookupByLibrary.simpleMessage("Created"),
        "daily_label": MessageLookupByLibrary.simpleMessage("Daily"),
        "delete_page": MessageLookupByLibrary.simpleMessage("Delete Page"),
        "edit_page": MessageLookupByLibrary.simpleMessage("Edit Page"),
        "event_modal_title": MessageLookupByLibrary.simpleMessage(
            "Select the page you want to migrate the selected event to!"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "exit_the_app": MessageLookupByLibrary.simpleMessage("Exit the app"),
        "explore_label": MessageLookupByLibrary.simpleMessage("Explore"),
        "home_label": MessageLookupByLibrary.simpleMessage("Home"),
        "info": MessageLookupByLibrary.simpleMessage("Info"),
        "last_event": MessageLookupByLibrary.simpleMessage("Last Event"),
        "name_of_the_page":
            MessageLookupByLibrary.simpleMessage("Name of the page"),
        "no_event": MessageLookupByLibrary.simpleMessage(
            "No Events. Click to create one"),
        "no_search_body": MessageLookupByLibrary.simpleMessage(
            "No entries match the given search query. Please try again"),
        "no_search_title":
            MessageLookupByLibrary.simpleMessage("No search result available"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pin_unpin": MessageLookupByLibrary.simpleMessage("Pin/Unpin Page"),
        "questionnaire":
            MessageLookupByLibrary.simpleMessage("Questionnaire bot"),
        "setting_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "timeline_label": MessageLookupByLibrary.simpleMessage("Timeline"),
        "title_add_image": MessageLookupByLibrary.simpleMessage("Add image"),
        "title_instruction": m1
      };
}
