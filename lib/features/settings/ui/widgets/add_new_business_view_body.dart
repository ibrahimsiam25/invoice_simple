import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
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
          ],
        ),
      ),
    );
  }
}
