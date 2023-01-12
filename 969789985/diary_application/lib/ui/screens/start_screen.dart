import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  var _isAppBarActions = true;
  var _isFabVisible = true;

  List<ChatModel> chatsList = List<ChatModel>.generate(
      6,
      (index) => ChatModel(index, 'Chat $index',
          'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth.'));

  @override
  Widget build(BuildContext context) {
    final animatedAppBarSwitcher = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(0.0, -2.0), end: const Offset(0.0, 0.0))
              .animate(animation),
          child: child,
        );
      },
      child: Text(
        _appBarTitle,
        key: ValueKey<String>(_appBarTitle),
        style: const TextStyle(fontSize: 24),
      ),
    );

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: animatedAppBarSwitcher,
        actions: [
          _isAppBarActions
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              : Container(
                  width: 0,
                ),
          _isAppBarActions
              ? IconButton(
                  onPressed: () {}, icon: const Icon(Icons.invert_colors))
              : Container(
                  width: 0,
                )
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
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isFabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
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
                    _isAppBarActions = true;
                    _isFabVisible = true;
                    break;
                  case 1:
                    _appBarTitle = 'Daily';
                    _isAppBarActions = false;
                    _isFabVisible = false;
                    break;
                  case 2:
                    _appBarTitle = 'Timeline';
                    _isAppBarActions = false;
                    _isFabVisible = false;
                    break;
                  case 3:
                    _appBarTitle = 'Explore';
                    _isAppBarActions = false;
                    _isFabVisible = false;
                    break;
                  default:
                    _appBarTitle = '';
                    _isAppBarActions = false;
                    _isFabVisible = false;
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
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(15.0),
                  onPressed: () {},
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.back_hand),
                      const SizedBox(width: 10),
                      const Text('Strange button')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!_isFabVisible) setState(() => _isFabVisible = true);
                  } else if (notification.direction == ScrollDirection.reverse) {
                    if (_isFabVisible) setState(() => _isFabVisible = false);
                  }

                  return true;
                },
                child: HomeListView(chatsList: chatsList),
              )
            ),
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
