import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/settings/ui/screens/signature_view.dart';
import 'package:invoice_simple/features/settings/ui/widgets/add_logo_widget.dart';
import 'package:invoice_simple/features/settings/ui/widgets/business_information_form.dart';

class AddNewBusinessViewBody extends StatelessWidget {
  const AddNewBusinessViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            AddLogoWidget(),
            SizedBox(height: 32.h),
            BusinessInformationForm(
              nameController: TextEditingController(),
              phoneController: TextEditingController(),
              emailController: TextEditingController(),
              addressController: TextEditingController(),
              onCurrencyChanged: (val) {},

            ),
            SizedBox(height: 60.h,),
            Text("You have no signature now",
            style: AppTextStyles.moFont20BlackWh600.copyWith(
              fontSize: 16.sp,
              color: AppColors.lightTextColor
              )
            ),
            SizedBox(height: 12.h),
            FilledTextButton(
              onPressed: () {
                // Navigate to signature view
                context.push(SignatureView.routeName);
              },
              color: AppColors.blue,
              text: "create a signature"),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
