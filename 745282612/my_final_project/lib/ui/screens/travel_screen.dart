import 'package:flutter/material.dart';

import '../../entities/message.dart';
import '../widgets/travel_screen/copy_message_button.dart';
import '../widgets/travel_screen/delete_button.dart';
import '../widgets/travel_screen/favorite_button.dart';
import '../widgets/travel_screen/travel_screen_body.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
  static _TravelScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_TravelScreenState>()!;
}

class _TravelScreenState extends State<TravelScreen> {
  List<Message> listMessage = [];
  List<Message> listFavoriteMesage = [];
  bool _isFavorite = false;
  bool _isSelected = false;
  bool _isCamera = false;
  String redactText = '';
  String pasteValue = '';
  void isSelected() {
    setState(
      () {
        _isSelected = !_isSelected;
        _isCamera = false;
        for (var element in listMessage) {
          if (element.isSelected && element.messageImage != null) {
            _isCamera = true;
          }
        }
      },
    );
  }

  void clearSelected() {
    setState(
      () {
        for (var element in listMessage) {
          if (element.isSelected) {
            element.isSelected = !element.isSelected;
          }
        }
        _isSelected = !_isSelected;
        redactText = '';
        _isCamera = false;
      },
    );
  }

  void redact() {
    setState(
      () {
        for (var i = 0; i < listMessage.length; i++) {
          if (listMessage[i].isSelected) {
            redactText = listMessage[i].messageContent;
          }
        }
      },
    );
  }

  void editMessage(String newText) {
    setState(
      () {
        for (var i = 0; i < listMessage.length; i++) {
          if (listMessage[i].isSelected) {
            listMessage[i].messageContent = newText;
            listMessage[i].isSelected = !listMessage[i].isSelected;
          }
        }
        isSelected();
        redactText = '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSelected
          ? AppBar(
              leading: TextButton(
                onPressed: clearSelected,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
              actions: [
                !_isCamera
                    ? TextButton(
                        onPressed: redact,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
                !_isCamera
                    ? CopyMessageButton(
                        listMessage: listMessage,
                      )
                    : const SizedBox(),
                DeleteButton(
                  listMessage: listMessage,
                ),
                FavoriteButton(
                  listMessage: listMessage,
                ),
              ],
            )
          : AppBar(
              title: const Text('Travel'),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        _isFavorite = !_isFavorite;
                      },
                    );
                  },
                  child: Icon(
                    _isFavorite ? Icons.turned_in : Icons.turned_in_not,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
      body: TravelScreenBody(
        isFavorite: _isFavorite,
        isSelected: _isSelected,
      ),
    );
  }
}
