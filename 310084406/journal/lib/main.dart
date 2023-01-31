import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              width: 10.0,
              height: 50.0,
              //child: Card(child: Text('Hello World!')),
            ),
            ListTile(
              leading: const Icon(Icons.label_important),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Light/Dark mode'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //const SizedBox(),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.label_important),
                    title: const Text('Necessary tasks'),
                    subtitle: const Text('No events. Click to create one'),
                    shape: const Border(bottom: BorderSide()),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_grocery_store),
                    title: const Text('Groceries'),
                    subtitle: const Text('No events. Click to create one'),
                    shape: const Border(bottom: BorderSide()),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.light_mode),
                    title: const Text('Days history'),
                    subtitle: const Text('No events. Click to create one'),
                    shape: const Border(bottom: BorderSide()),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        tooltip: 'add chat',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
