import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> items = [
    ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: const Icon(
          Icons.flight_takeoff,
          size: 32,
          color: Colors.white,
        ),
      ),
      title: const Text('Travel'),
      subtitle: const Text('No events. Click to create one.'),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {},
    ),
    ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: const Icon(
          Icons.weekend_outlined,
          color: Colors.white,
          size: 32,
        ),
      ),
      title: const Text('Family'),
      subtitle: const Text('No events. Click to create one.'),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {},
    ),
    ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: const Icon(
          Icons.fitness_center,
          color: Colors.white,
          size: 32,
        ),
      ),
      title: const Text('Sports'),
      subtitle: const Text('No events. Click to create one.'),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.invert_colors),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              tileColor: Theme.of(context).highlightColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.smart_toy_outlined,
                    size: 32,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Questionnaire Bot',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              visualDensity: const VisualDensity(vertical: 3),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Material(
                  child: items[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 16,
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore')
        ],
      ),
    );
  }
}
