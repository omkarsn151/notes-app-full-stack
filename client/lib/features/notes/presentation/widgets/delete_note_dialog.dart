import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteConfirmationDialog(BuildContext context, String noteId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Delete Note"),
        content: Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotesBloc>().add(DeleteNote(id: noteId));
              Navigator.of(context).pop(); 
            },
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
}