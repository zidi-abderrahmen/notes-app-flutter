import 'package:flutter/material.dart';

class NoteInputDialog extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final Function() onSave;

  const NoteInputDialog({
    super.key,
    required this.controller,
    required this.isEditing,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Edit Note' : 'Add New Note'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter your note here...',
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onSave();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
          child: Text('Save'),
        ),
      ],
    );
  }
}