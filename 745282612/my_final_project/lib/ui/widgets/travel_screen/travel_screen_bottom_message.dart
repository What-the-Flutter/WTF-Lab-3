import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';
import 'package:my_final_project/ui/widgets/travel_screen/modal_add_image.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class TravelScreenBottomMessage extends StatefulWidget {
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

  const TravelScreenBottomMessage({
    super.key,
    required this.controller,
    required this.isCamera,
    required this.addMessage,
    required this.addPicter,
  });

  @override
  State<TravelScreenBottomMessage> createState() =>
      _TravelScreenBottomMessageState();
}

class _TravelScreenBottomMessageState extends State<TravelScreenBottomMessage> {
  void eventOnLongPressed({required String editMessage}) {
    if (editMessage != '') {
    } else {
      widget.isCamera
          ? _showMyDialog('recipient')
          : widget.addMessage(
              content: widget.controller.text, type: 'recipient');
      Provider.of<ChatProvider>(context, listen: false).isUpdate();
    }
  }

  void eventOnPressed({
    required String editMessage,
    required String editText,
  }) {
    if (editMessage != '') {
      TravelScreen.of(context).editMessage(editText);
      Provider.of<ChatProvider>(context, listen: false).isUpdate();
    } else {
      widget.isCamera
          ? _showMyDialog('sender')
          : widget.addMessage(content: widget.controller.text, type: 'sender');
      Provider.of<ChatProvider>(context, listen: false).isUpdate();
    }
  }

  Future<void> _showMyDialog(String type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MyDialog(
          type: type,
          addPicter: widget.addPicter,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;
    final editMessage = TravelScreen.of(context).redactText;
    late final editController = TextEditingController(text: editMessage);

    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      alignment: Alignment.bottomLeft,
      child: ColoredBox(
        color: theme ? Colors.white : Colors.black,
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Icon(
                Icons.bubble_chart,
                size: 30,
                color: theme ? AppColors.colorTurquoise : Colors.white,
              ),
            ),
            Expanded(
              child: TextField(
                controller:
                    editMessage != '' ? editController : widget.controller,
                decoration: const InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  labelText: 'Enter Event',
                ),
              ),
            ),
            TextButton(
              onLongPress: () => eventOnLongPressed(editMessage: editMessage),
              onPressed: () => eventOnPressed(
                editText: editController.text,
                editMessage: editMessage,
              ),
              child: Icon(
                editMessage != ''
                    ? Icons.send
                    : widget.isCamera
                        ? Icons.camera_enhance
                        : Icons.send,
                size: 30,
                color: theme ? AppColors.colorTurquoise : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
