import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:flutter/material.dart';

class NoteDetailsDialog extends StatelessWidget {
  final NotesModel note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const NoteDetailsDialog({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onShare,
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
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share_rounded, color: AppColors.textColor),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Share",
                          color: AppColors.textColor,
                          fontSize: 18,
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
              } else if (value == 'share') {
                onShare();
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
