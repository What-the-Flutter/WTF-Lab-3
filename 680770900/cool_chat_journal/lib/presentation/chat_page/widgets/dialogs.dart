import 'package:flutter/material.dart';

import '../../../../data/models/chat.dart';
import '../../../utils/custom_theme.dart';

class DeleteDialog extends StatelessWidget {
  final int countSelectedEvents;

  const DeleteDialog({
    required this.countSelectedEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delete Entry(s)?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          Text(
            'Are you sure you want delete the '
            '$countSelectedEvents selected events?',
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            label: const Text('Delete'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(
              Icons.cancel,
              color: Colors.blue,
            ),
            label: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class TransferDialog extends StatefulWidget {
  final List<Chat> chats;
  const TransferDialog({
    super.key,
    required this.chats,
  });

  @override
  State<TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  String? _selectedChat;

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context).themeData;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        color: theme.primaryColor,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            children: [
              const Text('Select the page you want to migrate the selected '
                  'event(s) to!'),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.chats.length,
                  itemBuilder: (_, index) {
                    return RadioListTile(
                      title: Text(widget.chats[index].name),
                      activeColor: theme.backgroundColor,
                      value: widget.chats[index].id,
                      groupValue: _selectedChat,
                      onChanged: (value) => setState(
                        () => _selectedChat = value,
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                    ),
                    child: TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context, _selectedChat),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                    ),
                    child: TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, null),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
