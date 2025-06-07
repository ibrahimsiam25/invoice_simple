
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/widgets/cusotm_text_back_appbar.dart';
import 'package:invoice_simple/core/widgets/custom_scaffold.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/ui/widgets/business_view_body.dart';


class BusinessView extends StatelessWidget {
  const BusinessView({super.key});
  static const String routeName = "/business";

  @override
  Widget build(BuildContext context) {
    final users = List.generate(
      40,

      (index) => const BusinessUserModel(
        name: "John Doe",
        email: "yourmail@sample.com",
      ),
    );

    return CustomScaffold(
      backgroundColor: AppColors.background,
      appBar: CusotmTextBackAppbar(
        title: "Business",
      ),
     bottomNavigationBar: Padding(
       padding: EdgeInsets.only(bottom: 38.h, left: 24.w, right: 24.w),
       child: FilledTextButton(
          color: AppColors.blue,
        text: "Add New", onPressed: () {}),
     ),
      body: BusinessViewBody(users: users),
    );
  }
}
