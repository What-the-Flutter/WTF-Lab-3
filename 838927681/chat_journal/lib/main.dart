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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title='Home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.title),
        centerTitle: true,
        actions: const [
          MyMode(),
        ],
        ),
      drawer: const MyDrawer(),
      body: const MyBody(),
      bottomNavigationBar: const MyBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed:
        (){},
        tooltip: 'New',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyMode extends StatefulWidget{
  const MyMode({super.key});
  @override
  State<MyMode> createState()=> _MyModeState();
}

class _MyModeState extends State<MyMode>{
  bool _isDark=false;
  void _onModeIconTap(){
    setState(() {
      _isDark=!_isDark;
    });
  }
  @override
  Widget build(BuildContext context){
    var iconData = _isDark?Icons.light_mode:Icons.dark_mode;
    return IconButton(
        icon: Icon(iconData),
      onPressed: _onModeIconTap,
    );
  }
}

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: const Text(
                  'Chat Journal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

          ),
          const ListTile(
            title: Text('Help spread the word'),
            leading: Icon(Icons.card_giftcard),
          ),
          const ListTile(
            title: Text('Search'),
            leading: Icon(Icons.search),
          ),
          const ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications),
          ),
          const ListTile(
            title: Text('Statistics'),
            leading: Icon(Icons.analytics),
          ),
          const ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text('Feedback'),
            leading: Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}

class MyBody extends StatelessWidget{
  const MyBody({super.key});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const QuestionnaireBotButton(),
        Expanded(
            child:MyJournalList()
        ),
        //MyJournalList()

      ],
    );
  }
}
class QuestionnaireBotButton extends StatelessWidget{
  const QuestionnaireBotButton({super.key});
  @override
  Widget build (BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.question_answer),
                Text('Questionnaire Bot'),
              ],
            ),
            onPressed: (){},
          )
      ),
    );
  }
}

class JournalElement {
  String name;
  IconData icon;
  String lastMessage = '';
  List<String> events = <String>[];
  JournalElement({required this.name, required this.icon});
}
class MyJournalList extends StatelessWidget{
  MyJournalList({super.key});
  List<JournalElement> journalList = <JournalElement>[
    JournalElement(name: 'Travel', icon: Icons.travel_explore),
    JournalElement(name: 'Family', icon: Icons.family_restroom),
    JournalElement(name: 'Sport', icon: Icons.sports),
  ];
  @override
  Widget build (BuildContext context){
    return ListView.builder(
      itemCount: journalList.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
        var journalItem = journalList[i];
          return ListTile(
            title: Text(
              journalItem.name,
            ),
            subtitle: Text(journalItem.events.isNotEmpty?
            journalItem.events[journalItem.events.length-1]:'No events, Click to create one'),
            leading: Icon(
              journalList[i].icon
            ),
            onTap: (){},

              );
            },
          );
        }
}

class MyBottomNavigationBar extends StatefulWidget{
  const MyBottomNavigationBar({super.key});
  @override
  State<MyBottomNavigationBar> createState()=> _MyBottomNavigationBarState();
}
class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>{
  int _selectedIndex = 0;
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
            textTheme: const TextTheme(caption: TextStyle(color: Colors.blueGrey)),
      ),
        child:BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.view_day,
          ),
          label:'Daily',

        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.timeline,
          ),
          label: 'Timeline',


        ),
        BottomNavigationBarItem(

          icon: Icon(
              Icons.explore,
          ),
          label: 'Explore',
        )
      ],

      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.blueGrey,
      iconSize: 40,
onTap: _onItemTapped,
    )
    );
  }
}

