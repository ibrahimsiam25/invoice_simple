
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';

import '../theme/app_colors.dart';
void buildMessageBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
     
      content: Text(
        message,
        style: AppTextStyles.moFont20BlackWh500.copyWith(
          color: AppColors.white,
          fontSize: 14.sp,
        ),
      ),
    

    ),
  );
}
   