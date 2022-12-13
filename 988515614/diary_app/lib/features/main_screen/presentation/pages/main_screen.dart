import 'dart:async';

import 'package:diary_app/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});
  static const _tabNames = ['Home', 'Daily', 'Timeline', 'Explore'];

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final currentTab = useState(_tabNames[currentIndex.value]);
    final controller = usePageController(
      initialPage: 0,
    );

    return MaterialApp(
      title: 'Diary chat app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(CupertinoIcons.line_horizontal_3),
            onPressed: () {},
          ),
          title: Center(
            child: Text(
              currentTab.value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              icon: const Icon(CupertinoIcons.drop_fill),
              onPressed: () {},
            ),
          ],
        ),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePage(), // Home
            const Text('2nd'), // Daily
            const Text('3rd'), // Timeline
            const Text('4th'), // Explore
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex.value,
          selectedItemColor: Colors.teal.shade800,
          unselectedItemColor: Colors.grey.shade700,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            currentIndex.value = index;
            currentTab.value = _tabNames[index];
            controller.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.book,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Daily',
              icon: Icon(Icons.access_time_filled_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Timeline',
              icon: Icon(Icons.map),
            ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(Icons.architecture_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
