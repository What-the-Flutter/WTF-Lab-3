import 'package:flutter/material.dart';

import '../main_screen_section.dart';
import 'event_list.dart';
import 'questionnaire_button.dart';

class Home extends MainScreenSection {
  @override
  final String title = 'Home';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: QuestionnaireButton(),
          ),
          EventList(),
        ],
      ),
    );
  }
}
