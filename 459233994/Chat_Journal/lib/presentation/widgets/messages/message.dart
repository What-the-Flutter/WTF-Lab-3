import 'package:flutter/material.dart';

import '../../../domain/entities/packed_message.dart';
import 'inherited_list.dart';
import 'message_dialog.dart';

class Message extends StatefulWidget {
  final PackedMessage _packedMessage;

  Message({required packedMessage}) : _packedMessage = packedMessage;

  @override
  State<Message> createState() => _MessageState(packedMessage: _packedMessage);
}

class _MessageState extends State<Message> {
  final PackedMessage _packedMessage;
  double _leftPositionValue = 10;
  final GlobalKey _widgetKey = GlobalKey();

  _MessageState({required packedMessage}) : _packedMessage = packedMessage;

  double _getMessageWidth() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return size.width;
  }

  Widget conditionString() {
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
              style: const TextStyle(
                color: Color(0xff829399),
                fontSize: 12,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: (() {
                  if (_packedMessage.isDone) {
                    return const Icon(
                      Icons.check,
                      color: Color(0xff545F66),
                      size: 14,
                    );
                  }
                }())),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: (() {
                if (_packedMessage.isFavorite) {
                  return const Icon(
                    Icons.bookmark,
                    color: Color(0xff545F66),
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
                onHorizontalDragUpdate: (details) {
                  setState(
                    () {
                      if (_leftPositionValue +
                                  details.delta.dx +
                                  _getMessageWidth() <
                              MediaQuery.of(context).size.width &&
                          _leftPositionValue + details.delta.dx > 10) {
                        _leftPositionValue += details.delta.dx;
                      }
                    },
                  );
                },
                onHorizontalDragEnd: (details) {
                  setState(
                    () {
                      if (_leftPositionValue >
                          MediaQuery.of(context).size.width -
                              _getMessageWidth() -
                              10) {
                        if (_packedMessage.isDone) {
                          _packedMessage.isDone = false;
                        } else {
                          _packedMessage.isDone = true;
                        }
                      }
                      _leftPositionValue = 10;
                    },
                  );
                },
                onTap: () {
                  setState(() {
                    if (_packedMessage.isFavorite) {
                      _packedMessage.isFavorite = false;
                    } else {
                      _packedMessage.isFavorite = true;
                    }
                  });
                },
                onLongPress: () {
                  var events = InheritedList.of(context)?.events;
                  var refresh = InheritedList.of(context)?.notifyParent;
                  showDialog(
                    context: context,
                    builder: (context) {
                      if (_packedMessage.textMessage != null) {
                        return MessageDialog(
                            packedMessage: _packedMessage,
                            events: events,
                            refresh: refresh);
                      } else {
                        return Container();
                      }
                    },
                  );
                },
                child: (() {
                  if (_packedMessage.textMessage != null) {
                    return Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffE8FCC2),
                      ),
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _packedMessage.textMessage!.data,
                            softWrap: true,
                            style: const TextStyle(
                              color: Color(0xff545F66),
                              fontSize: 16,
                            ),
                          ),
                          conditionString(),
                        ],
                      ),
                    );
                  } else if (_packedMessage.imageMessage != null) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffE8FCC2),
                      ),
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _packedMessage.imageMessage!.file,
                                fit: BoxFit.contain,
                              ),
                            ),
                            width: 100,
                            height: 225,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          conditionString(),
                        ],
                      ),
                    );
                  }
                }()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
