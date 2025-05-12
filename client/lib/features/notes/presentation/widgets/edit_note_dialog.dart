import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void editNoteDialog(
  BuildContext context,
  String id,
  String title,
  String content,
) {
  final titleController = TextEditingController(text: title);
  final contentController = TextEditingController(text: content);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Edit Note"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: "Content"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final editedTitle = titleController.text.trim();
              final editedContent = contentController.text.trim();

              if (editedTitle.isNotEmpty && editedContent.isNotEmpty) {
                context.read<NotesBloc>().add(
                  EditNote(id: id, title: editedTitle, content: editedContent),
                );
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Title and content cannot be empty")),
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}
