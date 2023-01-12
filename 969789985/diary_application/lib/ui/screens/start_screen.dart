import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../basic/models/chat_model.dart';
import '../../widgets/home_list_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var _selectedIndexPage = 0;
  var _appBarTitle = 'Home';

  List<ChatModel> chatsList = List<ChatModel>.generate(
      6,
          (index) => ChatModel(index, 'Chat $index',
          'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth.'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.invert_colors))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.grey[100]!,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: CupertinoButton(
                onPressed: () {},
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blueGrey[100],
                child: const Text('Button 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {},
                color: Colors.blueGrey[100],
                child: const Text('Button 2'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
              child: CupertinoButton(
                onPressed: () {},
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blueGrey[100],
                child: const Text('Button 3'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xCCcfd8dc),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: GNav(
            gap: 5,
            tabBackgroundColor: const Color(0xFFcfd8dc),
            tabs: const [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: Icons.list_alt, text: 'Daily'),
              GButton(icon: Icons.timeline, text: 'Timeline'),
              GButton(icon: Icons.explore, text: 'Explore')
            ],
            onTabChange: (index) {
              setState(() {
                _selectedIndexPage = index;
                switch (_selectedIndexPage) {
                  case 0:
                    _appBarTitle = 'Home';
                    break;
                  case 1:
                    _appBarTitle = 'Daily';
                    break;
                  case 2:
                    _appBarTitle = 'Timeline';
                    break;
                  case 3:
                    _appBarTitle = 'Explore';
                    break;
                  default:
                    _appBarTitle = '';
                    break;
                }
              });
            },
          ),
        ),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    switch (_selectedIndexPage) {
      case 0:
        return Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(15.0),
                  onPressed: () {},
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite),
                      const SizedBox(width: 10),
                      const Text('?Strange button')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(child: HomeListView(chatsList: chatsList))
          ],
        );
      case 1:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case 2:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case 3:
        return const Center(
          child: CircularProgressIndicator(),
        );
      default:
        return Center(child: Text('Index error: $_selectedIndexPage'));
    }
  }
}
