import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'chats_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _body = ChatsPage();

  void _addListItem() {
    setState(() {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add tab'),
            ),
            body: const Center(
              child: Text(
                'Enter a name for new tab',
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Journal'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.invert_colors),
              tooltip: 'Switch color scheme',
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: _body
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addListItem,
          tooltip: 'Add new category',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: NotificationListener<TabChanged>(child: BottomNavigation(),
          onNotification: (n) {
            setState(() {
              _body = n.val;
            });
            return true;
          },),);
  }
}
