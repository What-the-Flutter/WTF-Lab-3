import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/travel_screen/copy_message_button.dart';
import 'package:my_final_project/ui/widgets/travel_screen/delete_button.dart';
import 'package:my_final_project/ui/widgets/travel_screen/favorite_button.dart';
import 'package:my_final_project/ui/widgets/travel_screen/travel_screen_body.dart';

class TravelScreen extends StatefulWidget {
  final List<Event> listEvent;
  final String title;

  const TravelScreen({
    super.key,
    required this.listEvent,
    required this.title,
  });

  @override
  State<TravelScreen> createState() => _TravelScreenState();
  static _TravelScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_TravelScreenState>()!;
}

class _TravelScreenState extends State<TravelScreen> {
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
        for (var element in widget.listEvent) {
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
        var index =
            widget.listEvent.indexWhere((element) => element.isSelected);
        widget.listEvent[index] = widget.listEvent[index]
            .copyWith(isSelected: !widget.listEvent[index].isSelected);
        _isSelected = !_isSelected;
        redactText = '';
        _isCamera = false;
      },
    );
  }

  void redact() {
    setState(
      () {
        for (var i = 0; i < widget.listEvent.length; i++) {
          if (widget.listEvent[i].isSelected) {
            redactText = widget.listEvent[i].messageContent;
          }
        }
      },
    );
  }

  void editMessage(String newText) {
    setState(
      () {
        var index =
            widget.listEvent.indexWhere((element) => element.isSelected);
        widget.listEvent[index] = widget.listEvent[index].copyWith(
            isSelected: !widget.listEvent[index].isSelected,
            messageContent: newText);
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
                    ? CopyMessageButton(listMessage: widget.listEvent)
                    : const SizedBox(),
                DeleteButton(
                  listMessage: widget.listEvent,
                ),
                FavoriteButton(
                  listMessage: widget.listEvent,
                ),
              ],
            )
          : AppBar(
              title: Text(widget.title),
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
        listEvent: widget.listEvent,
        title: widget.title,
      ),
    );
  }
}
