import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/packed_message.dart';

class MessageDialog extends StatefulWidget {
  final PackedMessage _packedMessage;
  final List<PackedMessage> _events;
  final Function _refresh;

  MessageDialog({required packedMessage, required events, required refresh})
      : _packedMessage = packedMessage,
        _events = events,
        _refresh = refresh;

  @override
  State<MessageDialog> createState() => _MessageDialogState(
      packedMessage: _packedMessage, events: _events, refresh: _refresh);
}

class _MessageDialogState extends State<MessageDialog> {
  final PackedMessage _packedMessage;
  final List<PackedMessage> _events;
  final Function _refresh;
  bool _isEdit = false;

  _MessageDialogState(
      {required packedMessage, required events, required refresh})
      : _packedMessage = packedMessage,
        _events = events,
        _refresh = refresh;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        height: 230,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              InkWell(
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xff545F66),
                    ),
                  ),
                ),
                onTap: () {
                  setState(
                    () {
                      if (_isEdit) {
                        _isEdit = false;
                      } else {
                        _isEdit = true;
                      }
                    },
                  );
                },
              ),
              (() {
                if (_isEdit) {
                  return TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xff829399),
                        ),
                      ),
                      hintText: 'Edit event',
                    ),
                    onSubmitted: (text) {
                      _packedMessage.textMessage?.data = text;
                      _refresh();
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                  );
                } else {
                  return Container();
                }
              }()),
              InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(
                      'Delete',
                      style: TextStyle(
                        color: Color(0xff545F66),
                      ),
                    ),
                  ),
                  onTap: () {
                    _events.remove(_packedMessage);
                    _refresh();
                    Navigator.of(context, rootNavigator: true).pop(true);
                  }),
              InkWell(
                child: const ListTile(
                  leading: Icon(Icons.content_copy),
                  title: Text(
                    'Copy',
                    style: TextStyle(
                      color: Color(0xff545F66),
                    ),
                  ),
                ),
                onTap: () async {
                  if (_packedMessage.textMessage != null) {
                    await Clipboard.setData(
                        ClipboardData(text: _packedMessage.textMessage?.data));
                  }
                  Navigator.of(context, rootNavigator: true).pop(true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
