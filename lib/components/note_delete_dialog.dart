import 'package:flutter/material.dart';

class NoteDeleteDialog extends StatelessWidget {
  final Function() onDelete;

  const NoteDeleteDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure?'),
      content: Text('Do you really want to delete this note? This process cannot be undone'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(foregroundColor: Color(0xFFEF4444)),
          child: Text('Delete'),
        ),
      ],
    );
  }
}