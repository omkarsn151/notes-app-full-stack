import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddNoteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => NoteDialog(
          title: 'Add Note',
          onSave: (title, content) {
            context.read<NotesBloc>().add(
              AddNote(title: title, content: content),
            );
          },
        ),
  );
}

void showEditNoteDialog(BuildContext context, NotesModel note) {
  showDialog(
    context: context,
    builder:
        (context) => NoteDialog(
          title: 'Edit Note',
          initialTitle: note.title,
          initialContent: note.content,
          onSave: (title, content) {
            context.read<NotesBloc>().add(
              EditNote(id: note.id, title: title, content: content),
            );
          },
        ),
  );
}

class NoteDialog extends StatefulWidget {
  final String title;
  final String? initialTitle;
  final String? initialContent;
  final Function(String title, String content) onSave;

  const NoteDialog({
    super.key,
    required this.title,
    this.initialTitle,
    this.initialContent,
    required this.onSave,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _contentController = TextEditingController(
      text: widget.initialContent ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
        ),
        ElevatedButton(
          onPressed: _saveNote,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both title and content'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    widget.onSave(title, content);
    Navigator.pop(context);
  }
}
