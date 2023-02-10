import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/chats_list.dart';
import '../widgets/left_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        drawer: const LeftDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
        ),
        body: const ChatList(),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {}),
          tooltip: 'add chat',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const BottomNavigation());
  }
}
