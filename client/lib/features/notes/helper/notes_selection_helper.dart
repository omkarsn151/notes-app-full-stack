import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
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
          backgroundColor: AppColors.bgColor,
          title: CustomText(
            text: "⚠️ Delete ${selectedNoteIds.length} notes",
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          content: CustomText(
            text:
                "Are you sure you want to delete the selected notes?\nThis action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const CustomText(
                text: "Cancel",
                color: AppColors.textColor,
              ),
            ),
            TextButton(
              onPressed: () {
                deleteSelectedNotes();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: CustomText(text: "Delete", color: AppColors.textColor),
            ),
          ],
        );
      },
    );
  }
}
