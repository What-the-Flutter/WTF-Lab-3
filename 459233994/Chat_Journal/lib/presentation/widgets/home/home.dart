import 'package:flutter/material.dart';

import '../../../domain/entities/event_page.dart';
import '../../screens/add_event_page.dart';
import '../app_theme/inherited_app_theme.dart';
import '../main_screen_section.dart';
import 'event_list.dart';
import 'questionnaire_button.dart';

class Home extends MainScreenSection {
  @override
  final String title = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<EventPage> _pages = [];

  void _refresh(){
   setState(() {

   });
  }

  Future<void> _addPage() async {
    final newPage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(
          theme: InheritedAppTheme.of(context)?.getTheme,
        ),
      ),
    );
    if (newPage != null) {
      _pages.add(newPage);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: QuestionnaireButton(),
            ),
            EventList(
              pages: _pages,
              refreshFunc: _refresh,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InheritedAppTheme.of(context)?.getTheme.actionColor,
        onPressed: () => {
          _addPage(),
        },
        child: Icon(
          Icons.add,
          color: InheritedAppTheme.of(context)?.getTheme.iconColor,
        ),
      ),
    );
  }
}
