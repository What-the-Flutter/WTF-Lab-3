import 'package:flutter/material.dart';

import '../app_theme/inherited_theme.dart';

class ImageSort extends StatefulWidget{
  @override
  State<ImageSort> createState() => _ImageSortState();
}

class _ImageSortState extends State<ImageSort> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Text(
          'Sort images',
          style: TextStyle(
              color: InheritedAppTheme.of(context)!.themeData.textColor),
        ),
    );
  }
}