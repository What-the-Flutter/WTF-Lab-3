import 'package:flutter/material.dart';

import '../../../entities/message.dart';
import '../../screens/travel_screen.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.listMessage,
  });
  final List<Message> listMessage;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  void _changeFavorite() {
    setState(
      () {
        for (var element in widget.listMessage) {
          if (element.isSelected) {
            element.isSelected = !element.isSelected;
            element.isFavorit = !element.isFavorit;
          }
        }
        TravelScreen.of(context).isSelected();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _changeFavorite,
      child: const Icon(
        Icons.turned_in_not,
        color: Colors.white,
      ),
    );
  }
}
