import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/widgets/cusotm_text_back_appbar.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';

import 'package:signature/signature.dart';


class SignatureView extends StatelessWidget {
  const SignatureView({super.key});
  static const String routeName = '/signatureView';

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = SignatureController(
  penStrokeWidth: 3,
  penColor: Colors.black,
  exportBackgroundColor: Colors.white,
);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:CusotmTextBackAppbar(title: "Create a Signature",),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
          child: Column(
            children: [
              Container(
                 height: 330.h,
          
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: AppColors.white),
                child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(5),
                color: AppColors.lightBlue,
                dashPattern: const [4, 4],
                strokeWidth: 1,
                child: Signature(controller: controller, backgroundColor: Colors.white),
                ),
              ),
            SizedBox(height: 12.h,),
            FilledTextButton(
              onPressed: () async{
                 if (controller.isNotEmpty) {
                    // Use the signature bytes as needed, e.g., save to storage or database
                    final signature = await controller.toPngBytes();
                     print(signature);
                  }
              },
              text: "Save")
            ],
          ),
        ),
      ),
    );
  }
}
