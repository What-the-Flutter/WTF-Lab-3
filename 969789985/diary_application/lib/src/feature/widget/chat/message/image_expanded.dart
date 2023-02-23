import 'dart:io';

import 'package:flutter/material.dart';

class ImageExpanded extends StatelessWidget {
  final File image;
  final String heroTag;
  final int index;
  final int imagesCount;

  const ImageExpanded({
    super.key,
    required this.index,
    required this.heroTag,
    required this.imagesCount,
    required this.image,
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
              if (details.delta.dy > 12.0) {
                Navigator.pop(context);
              }
              if (details.delta.dy < -12.0) {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.zero,
              child: Center(
                child: Hero(
                  tag: image.path.codeUnits,
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.85,
                    ),
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
