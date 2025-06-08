import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';

void showRequiredFieldsDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Attention"
        , style: AppTextStyles.poFont20BlackWh600
      ),
      content: Text(
        message,
        style: AppTextStyles.poFont20BlackWh400.copyWith(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14.sp),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}