import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_assets.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/add_row_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_header_row.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/section_label.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/summary_row.dart';
import 'package:svg_flutter/svg.dart';

class NewInvoiceViewBody extends StatelessWidget {
  const NewInvoiceViewBody({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                "New invoice",
                style: AppTextStyles.poFont20BlackWh600.copyWith(
                  fontSize: 26.sp,
                  color: AppColors.lightTextColor,
                ),
              ),
            ),
            SizedBox(height: 40.h),
    
            InvoiceHeaderRow(issued: "5 May 2025", due: "-", number: "001"),
            SizedBox(height: 18),
            // Business Account
            SectionLabel(label: 'Business account'),
            AddRowButton(
          
              text: "Choose Account",
              onTap: () {},
            ),
            SizedBox(height: 10),
            // Client
            SectionLabel(label: 'Client'),
            AddRowButton(
            
              text: "Add Client",
              onTap: () {},
            ),
            SizedBox(height: 10),
            // Items
            SectionLabel(label: 'Items'),
            AddRowButton(
            
              text: "Add Item",
              onTap: () {},
            ),
            SizedBox(height: 14),
            // Summary
            SectionLabel(label: 'Summary'),
            SummaryRow(
              currency: "USD",
              totalAmount: 0.00,
            ),
            SizedBox(height: 14),
            // Photos
            SectionLabel(label: 'Photos'),
            AddRowButton(
            
              text: "Add Photo",
              trailing: Container(
                decoration: BoxDecoration(
                  color: AppColors.blueGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.imagesSvgStar),
                    SizedBox(width: 4.w),
                    Text(
                      "premium",
                      style: AppTextStyles.poFont20BlackWh400.copyWith(
                        fontSize: 8.sp,
                      
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
    SizedBox(height: 100.h),
      FilledTextButton(text:"Create New Invoice", onPressed: () {}),
            SizedBox(height: 68.h),
          ],
        ),
      ),
    );
  }
}
