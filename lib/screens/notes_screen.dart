import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  NotesScreenState createState() => NotesScreenState();
}

class NotesScreenState extends State<NotesScreen> {
  // Sample initial notes data
  List<Map<String, dynamic>> notes = [
    {
      'id': '1',
      'content': 'Learn Flutter',
      'createdAt': DateFormat.yMMMMd('en_US').format(DateTime.now()),
    },
    {
      'id': '2',
      'content': 'Learn React Native',
      'createdAt': DateFormat.yMMMMd('en_US').format(DateTime.now()),
    },
    {
      'id': '3',
      'content': 'Complete the tutorial',
      'createdAt': DateFormat.yMMMMd('en_US').format(DateTime.now()),
    },
  ];

  // Controllers and state variables
  TextEditingController noteController = TextEditingController();
  Map<String, dynamic>? editingNote;

  // Function to add a new note
  void addNote() {
    if (noteController.text.trim().isEmpty) return;

    setState(() {
      if (editingNote != null) {
        // Update existing note
        for (int i = 0; i < notes.length; i++) {
          if (notes[i]['id'] == editingNote!['id']) {
            notes[i] = {
              ...notes[i],
              'content': noteController.text,
              'updatedAt': DateFormat.yMMMMd('en_US').format(DateTime.now()),
            };
            break;
          }
        }
        editingNote = null;
      } else {
        // Add new note
        final newNote = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': noteController.text,
          'createdAt': DateFormat.yMMMMd('en_US').format(DateTime.now()),
        };
        notes.insert(0, newNote);
      }
    });

    noteController.clear();
    Navigator.pop(context); // Close the dialog
  }

  // Function to delete a note
  void deleteNote(String id) {
    setState(() {
      notes.removeWhere((note) => note['id'] == id);
    });
  }

  // Function to open edit mode
  void editNote(Map<String, dynamic> note) {
    editingNote = note;
    noteController.text = note['content'];
    showNoteDialog();
  }

  // Show dialog for adding/editing notes
  void showNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editingNote != null ? 'Edit Note' : 'Add New Note'),
        content: TextField(
          controller: noteController,
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
            onPressed: addNote,
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with title and add button
          Container(
            height: 100,
            color: Colors.blue,
            padding: EdgeInsets.only(
              bottom: 15,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    editingNote = null;
                    noteController.clear();
                    showNoteDialog();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notes list or empty state
          Expanded(
            child: notes.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    note['content'],
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    note['createdAt'],
                                    style: TextStyle(fontSize: 10, color: Colors.grey),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => editNote(note),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        deleteNote(note['id']),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No notes yet. Create one!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF7F8C8D),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    noteController.dispose();
    super.dispose();
  }
}