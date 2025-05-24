import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Expanded(
            child: CustomText(
              text: note.title,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          PopupMenuButton(
            color: AppColors.subTextColor,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textColor,
            ),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_note_rounded),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Edit",
                          fontSize: 18,
                          color: AppColors.bgColor,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.errorColor),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Delete",
                          color: AppColors.errorColor,
                          fontSize: 18,
                        ),
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
        child: SingleChildScrollView(child: CustomText(text: note.content)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const CustomText(text: "Close"),
        ),
      ],
    );
  }
}
