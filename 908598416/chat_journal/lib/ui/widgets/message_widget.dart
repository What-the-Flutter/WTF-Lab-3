import 'package:flutter/material.dart';

import '../../data/constants/color_constants.dart';
import '../../data/models/message.dart';
import '../../data/providers/message_provider.dart';
import '../screens/full_photo_screen.dart';

class MessageWidget extends StatelessWidget {
  final int _index;
  final Message _message;
  final BuildContext context;

  MessageWidget(this.context, this._index, this._message);

  @override
  Widget build(BuildContext context) {
    return message(_index, _message);
  }

  Widget message(int _index, Message message) {
    return Row(
      children: <Widget>[
        message.isPinned == true
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        message.type == TypeMessage.text
            // Text
            ? Container(
                child: Text(
                  message.content,
                  style: const TextStyle(color: ColorConstants.primaryColor),
                ),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                width: 200,
                decoration: BoxDecoration(
                    color: ColorConstants.greyColor2,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.only(bottom: 20, right: 10),
              )
            : message.type == TypeMessage.image
                // Image
                ? Container(
                    child: OutlinedButton(
                      child: Material(
                        child: Image.network(
                          message.content,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: const BoxDecoration(
                                color: ColorConstants.greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              width: 200,
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.themeColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              clipBehavior: Clip.hardEdge,
                            );
                          },
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPhotoPage(
                              url: message.content,
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                    ),
                    margin: const EdgeInsets.only(bottom: 20, right: 10),
                  )
                // Sticker
                : Container(
                    child: Image.asset(
                      'images/${message.content}.gif',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    margin: const EdgeInsets.only(bottom: 20, right: 10),
                  ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}
