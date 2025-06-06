import 'package:flutter/material.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';

class OutlinedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const OutlinedTextButton({
    super.key,
    required this.text,
   
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          text,
          style: AppTextStyles.moFont20BlackWh500.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}