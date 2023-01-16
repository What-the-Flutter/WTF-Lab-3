import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final screens = [
    Home(),
    Daily(),
    TimeLine(),
    Explore(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB1CC74),
        leading: const Icon(Icons.list),
        title: Center(child: Text(screens[index].title)),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: const Icon(Icons.contrast))
        ],
      ),
      body: screens[index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffD0F4EA),
        onPressed: () => {},
        child: const Icon(
          Icons.add,
          color: Color(0xff829399),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xff829399),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
                color: Color(0xff829399),
              ),
              label: 'Daily'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timeline,
                color: Color(0xff829399),
              ),
              label: 'TimeLine'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: Color(0xff829399),
              ),
              label: 'Explore'),
        ],
        onTap: (index) {
          setState(() => this.index = index);
        },
      ),
    );
  }
}

class QuestionnaireButton extends StatelessWidget {
  const QuestionnaireButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        backgroundColor: const Color(0xFFE8FCC2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.psychology, color: Color(0xff545F66),),
            Text('Questionnaire bot', style: TextStyle(color: Color(0xff545F66)),),
          ],
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  EventList({
    Key? key,
  }) : super(key: key);

  final List eventNames = ['Travel', 'Family', 'Sports'];
  final List eventIcons = [
    const Icon(Icons.airplanemode_active),
    const Icon(Icons.living_outlined),
    const Icon(Icons.sports_basketball)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: eventNames.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return ListTile(
          hoverColor: const Color(0xffD0F4EA),
          title: Text(eventNames[index]),
          subtitle: const Text('No events'),
          leading: eventIcons[index],
          onTap: () => {},
        );
      },
    );
  }
}

abstract class ScreenSection extends StatelessWidget {
  abstract final String title;
}

class Home extends ScreenSection {
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

class Daily extends ScreenSection {
  @override
  final String title = 'Daily';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class TimeLine extends ScreenSection {
  @override
  final String title = 'TimeLine';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Explore extends ScreenSection {
  @override
  final String title = 'Explore';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

