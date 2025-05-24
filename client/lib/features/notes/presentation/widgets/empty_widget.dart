import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_outlined, size: 80, color: AppColors.subTextColor),
            const SizedBox(height: 24),
            CustomText(
              text: "No notes yet",
              fontSize: 25,
              color: AppColors.subTextColor,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: "Tap the + button to create your first note",
              fontSize: 18,
              color: AppColors.subTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
