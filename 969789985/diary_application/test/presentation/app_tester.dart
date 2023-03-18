import 'package:flutter/material.dart';

class AppTester extends StatelessWidget {
  final Widget? bodyWidget;
  final Widget? bottomNavBarWidget;
  final List<Widget>? actionsWidgets;

  const AppTester({
    this.bodyWidget,
    this.bottomNavBarWidget,
    this.actionsWidgets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: actionsWidgets ?? null,
        ),
        body: bodyWidget ?? null,
        bottomNavigationBar: bottomNavBarWidget ?? null,
      ),
    );
  }
}
