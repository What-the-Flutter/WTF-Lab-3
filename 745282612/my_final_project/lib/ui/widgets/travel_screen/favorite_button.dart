import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';

class FavoriteButton extends StatefulWidget {
  final List<Event> listMessage;

  const FavoriteButton({
    super.key,
    required this.listMessage,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  void _changeFavorite() {
    setState(
      () {
        var index =
            widget.listMessage.indexWhere((element) => element.isSelected);
        widget.listMessage[index] = widget.listMessage[index].copyWith(
          isSelected: !widget.listMessage[index].isSelected,
          isFavorit: !widget.listMessage[index].isFavorit,
        );
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
