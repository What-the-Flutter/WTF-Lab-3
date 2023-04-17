import 'package:flutter/material.dart';

import '../app_theme/inherited_theme.dart';

class LabelSort extends StatefulWidget{
  @override
  State<LabelSort> createState() => _LabelSortState();
}

class _LabelSortState extends State<LabelSort> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Text(
        'Sort labels',
        style: TextStyle(
            color: InheritedAppTheme.of(context)!.themeData.textColor),
      ),
    );
  }
}