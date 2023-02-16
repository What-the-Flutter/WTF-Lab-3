import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final int countSelectedEvents;

  const DeleteDialog(this.countSelectedEvents);

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