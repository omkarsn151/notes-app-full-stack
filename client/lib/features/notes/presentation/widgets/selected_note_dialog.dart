import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/edit_note_dialog.dart';
import 'package:flutter/material.dart';

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

class NoteDetailsDialog extends StatelessWidget {
  final NotesModel note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteDetailsDialog({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Expanded(
            child: Text(
              note.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: const Row(
                      children: [
                        Icon(Icons.edit_outlined),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: const Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Text(
            note.content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}