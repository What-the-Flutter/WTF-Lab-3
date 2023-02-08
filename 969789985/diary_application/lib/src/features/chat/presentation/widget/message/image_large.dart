import 'dart:io';

import 'package:flutter/material.dart';

class ImageLarge extends StatelessWidget {
  final String imagePath;
  final String heroTag;
  final int index;
  final int imagesCount;

  const ImageLarge({
    super.key,
    required this.imagePath,
    required this.heroTag,
    required this.index,
    required this.imagesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$index of $imagesCount'),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.globalPosition.dy > 400.0) {
                Navigator.pop(context);
              }
            },
            child: Center(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  child: Image.file(
                    File(imagePath),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
