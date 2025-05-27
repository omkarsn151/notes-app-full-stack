import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/common/custom_textfied.dart';
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
            try {
              context.read<NotesBloc>().add(
              AddNote(title: title, content: content),
            );
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note added successfully!')),
          );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding note $e')),
          );
            }
            
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
  final _formKey = GlobalKey<FormState>();

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
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: CustomText(
        text: widget.title,
        fontWeight: FontWeight.w500,
        fontSize: 25,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _titleController,
                labelText: "Title",
                hintText: "Title",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _contentController,
                labelText: "Content",
                hintText: "Content",
                minLines: 5,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: CustomText(text: "Cancel"),
        ),
        ElevatedButton(
          onPressed: _saveNote,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.saveButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const CustomText(text: "Save", color: AppColors.bgColor),
        ),
      ],
    );
  }

  void _saveNote() {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    widget.onSave(title, content);
    Navigator.pop(context);
  }
}
