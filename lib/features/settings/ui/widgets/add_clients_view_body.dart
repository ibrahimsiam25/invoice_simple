import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/features/settings/ui/widgets/search_field.dart';

class AddClientsViewBody extends StatelessWidget {
  const AddClientsViewBody({
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
          SizedBox(height: 22.h),
          Align(
            alignment: Alignment.centerLeft,
            child:   Text(
                'Yulia',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 14.sp,
                ),
              ),
          ),
          SizedBox(height: 12.h), 
       Divider(
        height: 0,
        thickness: 0.35,
    color:AppColors.blueGrey
        )
        
        ],
      ),
    ),
        );
  }
}
