import 'package:flutter/material.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1,
      color: AppColors.extraLightGreyDivder
    );

  }
}
