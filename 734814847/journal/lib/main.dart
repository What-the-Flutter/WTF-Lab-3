import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    var numOfElements = 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.invert_colors),
          ),
        ],
      ),

      body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.background,
              margin: const EdgeInsets.symmetric(vertical: 15.0,
                                                  horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 15.0,
                                                  horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.smart_toy, color: Colors.white,),
                  const SizedBox(width: 10,),
                  Text(
                    style: style,
                    'Questionnaire Bot',
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Icon icon;
                    String text;
                    switch (index) {
                      case 0:
                        icon = const Icon(Icons.airplanemode_active, color: Colors.white,);
                        text = 'Travel';
                        break;
                      case 1:
                        icon = const Icon(Icons.chair, color: Colors.white,);
                        text = 'Family';
                        break;
                      default:
                        icon = const Icon(Icons.fitness_center, color: Colors.white,);
                        text = 'Sports';
                        break;
                    }
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 168, 105, 98),
                          shape: BoxShape.circle,
                        ),
                        child: icon,
                      ),
                      title: Text(text),
                      subtitle: const Text('No events'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 5,);
                  },
                  itemCount: numOfElements,
                )
            )
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'daily'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'timeline'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'explore'
          ),
        ],
      ),
    );
  }
}
