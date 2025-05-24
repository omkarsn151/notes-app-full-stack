import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteConfirmationDialog(BuildContext context, String noteId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.bgColor,
        title: CustomText(
          text: "⚠️ Delete Note",
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        content: CustomText(
          text:
              "Are you sure you want to delete this note?\nThis action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: CustomText(text: "Cancel", color: AppColors.textColor),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotesBloc>().add(DeleteNote(id: noteId));
              Navigator.of(context).pop();
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
