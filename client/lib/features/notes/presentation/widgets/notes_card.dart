import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final NotesModel note;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;
  final bool isSelectionMode;

  const NoteCard({
    super.key,
    required this.note,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onDelete,
    required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isSelected
                ? BorderSide(color: AppColors.saveButtonColor, width: 2)
                : BorderSide(color: AppColors.textColor, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: note.title,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelectionMode)
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color:
                          isSelected
                              ? AppColors.saveButtonColor
                              : AppColors.subTextColor,
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: AppColors.subTextColor,
                      onPressed: onDelete,
                    ),
                ],
              ),
              CustomText(
                text: note.content,
                fontSize: 16,
                color: AppColors.subTextColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
