import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/features/settings/ui/widgets/search_field.dart';

class AddItemViewBody extends StatelessWidget {
  const AddItemViewBody({
    super.key,
    required this.myController,
  });

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: Column(
          children: [
            SearchField(
              controller: myController,
              onChanged: (text) {
                print('Search: $text');
              },
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '0.00\$',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Container(height: 0.75.h, color: AppColors.blueGrey),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Yulia',
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  '2 000,00\$',
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.blueGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
