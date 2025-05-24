import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/edit_note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin NotesSelectionHelper<T extends StatefulWidget> on State<T> {
  final Set<String> selectedNoteIds = {};

  void toggleSelection(String id) {
    setState(() {
      if (selectedNoteIds.contains(id)) {
        selectedNoteIds.remove(id);
      } else {
        selectedNoteIds.add(id);
      }
    });
  }

  void clearSelection() {
    setState(() {
      selectedNoteIds.clear();
    });
  }

  void deleteSelectedNotes() {
    for (final id in selectedNoteIds) {
      context.read<NotesBloc>().add(DeleteNote(id: id));
    }
    clearSelection();
  }

  void showMultipleDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete ${selectedNoteIds.length} notes"),
          content: const Text(
            "Are you sure you want to delete the selected notes?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteSelectedNotes();
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

Future showSelectedNoteDialog(BuildContext context, NotesModel note) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(note.title),
              IconButton(
                onPressed:
                    () => editNoteDialog(
                      context,
                      note.id,
                      note.title,
                      note.content,
                    ),
                icon: Icon(Icons.edit_note_rounded),
              ),
            ],
          ),
          content: SingleChildScrollView(child: Text(note.content)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () => showDeleteConfirmationDialog(context, note.id),
              child: Text('Delete'),
            ),
          ],
        ),
  );
}
