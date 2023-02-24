import 'package:flutter/material.dart';
import '../widgets/chat_page_widgets/chats_list.dart';
import '../widgets/home_page_widgets/bottom_navigation_bar.dart';
import '../widgets/home_page_widgets/left_drawer.dart';
import '../widgets/utils/themes.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: themeFlag ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        drawer: const LeftDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(
                    () {
                      themeFlag = !themeFlag;
                    },
                  );
                },
                icon: const Icon(Icons.color_lens))
          ],
        ),
        body: const ChatList(),
        bottomNavigationBar: const BottomNavigation());
  }
}
