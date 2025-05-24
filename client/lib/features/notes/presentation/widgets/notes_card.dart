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
      elevation: isSelected ? 2 : 1,
      color: isSelected ? Colors.blue[50] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isSelected
                ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
                : BorderSide.none,
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
                    child: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelectionMode)
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color:
                          isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: Colors.grey[600],
                      onPressed: onDelete,
                      tooltip: 'Delete note',
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
