import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.subTextColor),
            const SizedBox(height: 16),
            CustomText(
              text: "Error",
              color: AppColors.subTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: message,
              fontSize: 16,
              color: AppColors.subTextColor,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: AppColors.bgColor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: const CustomText(
                  text: "Try Again",
                  fontSize: 18,
                  color: AppColors.bgColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
