import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(text: message),
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.subTextColor,
      showCloseIcon: true,
    ),
  );
}
