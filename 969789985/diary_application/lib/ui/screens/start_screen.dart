import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../basic/repositories/chat_repository.dart';
import '../../widgets/chat_list/chat_list_view.dart';
import 'new_chat_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndexPage = 0;
  String _appBarTitle = 'Home';
  bool _isAppBarActions = true;
  bool _isFabVisible = true;

  final ChatRepository _chatRepository = ChatRepository.get();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFf1eaea),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animatedAppBarSwitcher = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -2.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          _isAppBarActions
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              : Container(width: 0),
          _isAppBarActions
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.invert_colors),
                )
              : Container(width: 0)
        ],
      ),
      drawer: _navigationDrawer(),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pageContent(),
    );
  }

  Widget _pageContent() {
    switch (_selectedIndexPage) {
      case 0:
        return Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!_isFabVisible) setState(() => _isFabVisible = true);
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (_isFabVisible) setState(() => _isFabVisible = false);
                  }

                  return true;
                },
                child: HomeListView(chatsList: _chatRepository.chats),
              ),
            ),
          ],
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _bottomNavigationBar() => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: GNav(
            gap: 5,
            tabBackgroundColor: Theme.of(context).primaryColor,
            tabs: const [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: Icons.list_alt, text: 'Daily'),
              GButton(icon: Icons.timeline, text: 'Timeline'),
              GButton(icon: Icons.explore, text: 'Explore')
            ],
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndexPage = index;
                  switch (_selectedIndexPage) {
                    case 0:
                      _isAppBarActions = true;
                      _isFabVisible = true;
                      break;
                    default:
                      _isAppBarActions = false;
                      _isFabVisible = false;
                      break;
                  }
                },
              );
            },
          ),
        ),
      );

  Widget _navigationDrawer() => Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );

  Widget _floatingActionButton() => AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isFabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1 : 0,
          child: FloatingActionButton(
            onPressed: _toNewChatScreen,
            child: const Icon(Icons.add),
          ),
        ),
      );

  void _toNewChatScreen() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewChatScreen(),
        ),
      );
}
