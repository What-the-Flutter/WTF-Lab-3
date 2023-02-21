import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var items = [
    ListTile(
      leading: Container(
        child: Icon(
          Icons.flight_takeoff,
          size: 32,
          color: Colors.white,
        ),
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
      ),
      title: Text('Travel'),
      subtitle: Text('No events. Click to create one.'),
    ),
    ListTile(
      leading: Container(
        child: Icon(
          Icons.chair,
          color: Colors.white,
          size: 32,
        ),
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
      ),
      title: Text('Family'),
      subtitle: Text('No events. Click to create one.'),
    ),
    ListTile(
      leading: Container(
        child: Icon(
          Icons.fitness_center,
          color: Colors.white,
          size: 32,
        ),
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
      ),
      title: Text('Sports'),
      subtitle: Text('No events. Click to create one.'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.invert_colors),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              tileColor: Theme.of(context).highlightColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.smart_toy_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Questionnaire Bot',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              visualDensity: VisualDensity(vertical: 3),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index];
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            size: 32,
          ),
          elevation: 16,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
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
