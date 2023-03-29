import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final String imageSource;

  const ImagePage({
    required this.imageSource,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageSource,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            elevation: 16,
            child: const Icon(
              Icons.arrow_back,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
}
