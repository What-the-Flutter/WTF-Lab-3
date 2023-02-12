import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delete Page?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Are you sure you want delete this page?',
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