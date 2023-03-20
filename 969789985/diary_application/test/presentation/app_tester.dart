import 'package:flutter/material.dart';

class AppTester extends StatelessWidget {
  final Widget? bodyWidget;
  final Widget? bottomNavBarWidget;
  final List<Widget>? actionsWidgets;
  final Widget? appBarTitle;

  const AppTester({
    this.bodyWidget,
    this.appBarTitle,
    this.bottomNavBarWidget,
    this.actionsWidgets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: appBarTitle ?? null,
          actions: actionsWidgets ?? null,
        ),
        body: bodyWidget ?? null,
        bottomNavigationBar: bottomNavBarWidget ?? null,
      ),
    );
  }
}
