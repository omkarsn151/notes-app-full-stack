import 'package:client/common/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final int? minLines;
  final bool? alignLabelWithHint;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.textCapitalization,
    this.maxLines,
    this.minLines,
    this.alignLabelWithHint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.saveButtonColor,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator:
          validator ??
          (value) {
            if ((value == null || value.trim().isEmpty) &&
                (labelText != null)) {
              return "*$labelText can't be empty";
            }
            return null;
          },
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.sentences,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(color: AppColors.textColor),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.subTextColor),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.subTextColor, fontSize: 14),
        errorStyle: TextStyle(color: Colors.red.shade500),
        helperText: helperText,
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.textColor, size: 20)
                : null,
        suffixIcon:
            suffixIcon != null
                ? IconButton(
                  icon: Icon(suffixIcon, color: Colors.grey, size: 20),
                  onPressed: onSuffixIconTap,
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.saveButtonColor, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red.shade500, width: 1.2),
        ),
      ),
    );
  }
}
