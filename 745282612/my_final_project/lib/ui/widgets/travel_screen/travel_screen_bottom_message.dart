import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/app_colors.dart';
import '../../screens/travel_screen.dart';

class TravelScreenBottomMessage extends StatelessWidget {
  const TravelScreenBottomMessage({
    super.key,
    required this.controller,
    required this.isCamera,
    required this.addMessage,
    required this.addPicter,
  });
  final TextEditingController controller;
  final bool isCamera;
  final Function({
    required String content,
    required String type,
  }) addMessage;
  final Function({
    required XFile? pickedFile,
    required String type,
  }) addPicter;

  @override
  Widget build(BuildContext context) {
    final editMessage = TravelScreen.of(context).redactText;
    late final editController = TextEditingController(text: editMessage);
    Future<void> _showMyDialog(String type) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: const Text('Add image'),
            content: const Text(
                'If you click on the  camera icon, you can add an image from the camera, if you click on the photo icon, you can add an image from the phone.'),
            actions: <Widget>[
              TextButton(
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColors.colorTurquoise,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  addPicter(pickedFile: pickedFile, type: type);
                },
              ),
              TextButton(
                child: const Icon(
                  Icons.picture_as_pdf,
                  color: AppColors.colorTurquoise,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  addPicter(pickedFile: pickedFile, type: type);
                },
              ),
              TextButton(
                child: const Icon(
                  Icons.exit_to_app,
                  color: AppColors.colorTurquoise,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.bubble_chart,
              size: 30,
              color: AppColors.colorTurquoise,
            ),
          ),
          Expanded(
            child: TextField(
              controller: editMessage != '' ? editController : controller,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(240, 240, 240, 1),
                border: InputBorder.none,
                labelText: 'Enter Event',
              ),
            ),
          ),
          TextButton(
            onLongPress: editMessage != ''
                ? () {}
                : isCamera
                    ? () {
                        _showMyDialog('recipient');
                      }
                    : () {
                        addMessage(content: controller.text, type: 'recipient');
                      },
            onPressed: editMessage != ''
                ? () {
                    TravelScreen.of(context).editMessage(editController.text);
                  }
                : isCamera
                    ? () {
                        _showMyDialog('sender');
                      }
                    : () {
                        addMessage(content: controller.text, type: 'sender');
                      },
            child: Icon(
              editMessage != ''
                  ? Icons.send
                  : isCamera
                      ? Icons.camera_enhance
                      : Icons.send,
              size: 30,
              color: AppColors.colorTurquoise,
            ),
          ),
        ],
      ),
    );
  }
}
