
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
void buildMessageBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500), // مدة الظهور
      content: Text(
        message,
        style: TextStyle(color: AppColors.black), // لون النص
      ),
      backgroundColor: AppColors.white, // لون الخلفية

    ),
  );
}
