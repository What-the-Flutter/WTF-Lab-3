import 'package:flutter/material.dart';

import '../../../domain/entities/packed_message.dart';
import '../app_theme/inherited_app_theme.dart';
import 'message_dialog.dart';

class Message extends StatefulWidget {
  final PackedMessage _packedMessage;

  Message({required packedMessage}) : _packedMessage = packedMessage;

  @override
  State<Message> createState() => _MessageState(packedMessage: _packedMessage);
}

class _MessageState extends State<Message> {
  PackedMessage _packedMessage;
  double _leftPositionValue = 10;
  final GlobalKey _widgetKey = GlobalKey();

  _MessageState({required packedMessage}) : _packedMessage = packedMessage;

  double _getMessageWidth() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return size.width;
  }

  Widget _messageContent() {
    if (_packedMessage.textData != null) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: InheritedAppTheme.of(context)?.getTheme.auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _packedMessage.textData!,
              softWrap: true,
              style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor,
                fontSize: 16,
              ),
            ),
            _conditionString(),
          ],
        ),
      );
    } else if (_packedMessage.imageData != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:  InheritedAppTheme.of(context)?.getTheme.auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _packedMessage.imageData!,
                  fit: BoxFit.contain,
                ),
              ),
              width: 100,
              height: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            _conditionString(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _conditionString() {
    return SizedBox(
      width: 75,
      height: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              _packedMessage.createTime,
              style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor,
                fontSize: 12,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: (() {
                  if (_packedMessage.isDone) {
                    return Icon(
                      Icons.check,
                      color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                      size: 14,
                    );
                  }
                }())),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: (() {
                if (_packedMessage.isFavorite) {
                  return Icon(
                    Icons.bookmark,
                    color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                    size: 14,
                  );
                }
              }()),
            ),
          ],
        ),
      ),
    );
  }

  void _horizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(
      () {
        if (_leftPositionValue + details.delta.dx + _getMessageWidth() <
                MediaQuery.of(context).size.width &&
            _leftPositionValue + details.delta.dx > 10) {
          _leftPositionValue += details.delta.dx;
        }
      },
    );
  }

  void _horizontalDragEndHandler(DragEndDetails details) {
    setState(
      () {
        if (_leftPositionValue >
            MediaQuery.of(context).size.width - _getMessageWidth() - 10) {
          if (_packedMessage.isDone) {
            _packedMessage.updateDoneState(_packedMessage, false);
          } else {
            _packedMessage.updateDoneState(_packedMessage, true);
          }
        }
        _leftPositionValue = 10;
      },
    );
  }

  void _tapHandler() {
    setState(
      () {
        if (_packedMessage.isFavorite) {
          _packedMessage.updateFavoriteState(_packedMessage, false);
        } else {
          _packedMessage.updateFavoriteState(_packedMessage, true);
        }
      },
    );
  }

  void _longPressHandler() {
    // var events = InheritedList.of(context)?.events;
    // var refresh = InheritedList.of(context)?.notifyParent;
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     if (_packedMessage.textData != null) {
    //       return MessageDialog(
    //           packedMessage: _packedMessage, events: events, refresh: refresh);
    //     } else {
    //       return Container();
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Icon(
                Icons.check_circle,
                color: Color(0xff545F66),
                size: 25,
              ),
            ),
            Padding(
              key: _widgetKey,
              padding: EdgeInsets.only(left: _leftPositionValue),
              child: GestureDetector(
                onHorizontalDragUpdate: _horizontalDragUpdateHandler,
                onHorizontalDragEnd: _horizontalDragEndHandler,
                onTap: _tapHandler,
                onLongPress: _longPressHandler,
                child: _messageContent(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
