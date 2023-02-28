import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../theme/theme_scope.dart';
import 'background_color_picker.dart';

class BackgroundSelectorSheet extends StatelessWidget {
  final BuildContext bContext;

  const BackgroundSelectorSheet({
    super.key,
    required this.bContext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.large,
        horizontal: Insets.medium,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.large),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 0,
                color: Color(ThemeScope.of(context).state.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.appConstant),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _systemUiMode(SystemUiMode.edgeToEdge);
                  _showColorPicker(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.large),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.color_lens_outlined,
                        size: IconsSize.large,
                      ),
                      SizedBox(width: Insets.medium),
                      Text(
                        'Select color',
                        style: TextStyle(fontSize: FontsSize.normal),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Insets.large),
              MaterialButton(
                elevation: 0,
                color: Color(ThemeScope.of(context).state.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.appConstant),
                ),
                onPressed: () async {
                  final path = await _pickImages(
                    context,
                    source: ImageSource.gallery,
                  );

                  if(path != '') {
                    ThemeScope.of(context).imagePath(path);
                  }

                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.large),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image,
                        size: IconsSize.large,
                      ),
                      SizedBox(width: Insets.medium),
                      Text(
                        'Select image',
                        style: TextStyle(fontSize: FontsSize.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const BackgroundColorPicker(),
    );
  }

  void _systemUiMode(SystemUiMode uiMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black.withOpacity(0.002),
      ),
    );
  }

  Future<String> _pickImages(BuildContext context,
      {ImageSource? source}) async {
    try {
      final images = List<XFile?>.empty(growable: true);
      if (source != null) {
        images.add(await ImagePicker().pickImage(source: source));
      } else {
        images.addAll(await ImagePicker().pickMultiImage());
      }

      if (images.contains(null)) return '';

      final fromXFile = File(images.first!.path);

      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final appDocumentsPath = appDocumentsDirectory.path;
      final localImagePath = '$appDocumentsPath/${basename(fromXFile.path)}';

      await images.first!.saveTo(localImagePath);

      return localImagePath;
    } on PlatformException catch (e) {
      print('Platform exception: $e');
      Navigator.of(context).pop();
      return '';
    }
  }
}
