import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_assets.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_details_view_app_bar.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_header_section.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/payment_method.dart';
import 'package:svg_flutter/svg.dart';


class InvoiceDetailsView extends StatefulWidget {
  const InvoiceDetailsView({super.key});
  static const String routeName = '/invoice-details';

  @override
  State<InvoiceDetailsView> createState() => _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends State<InvoiceDetailsView> {
  bool isPaid = false;
  PaymentMethod? selectedMethod;
  double amount = 2000.00; // اجعلها ديناميكية حسب بياناتك

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: InvoiceDetailsViewAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 176.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                InvoiceHeaderSection(
                  isPaid: isPaid,
                  paymentMethod: selectedMethod,
                  amount: amount,
                ),
                const SizedBox(height: 20),
                // Invoice Status Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingHorizontal,
                  ),
                  child: InvoiceStatusSection(
                    onPaymentMethodSelected: (method) {
                      setState(() {
                        isPaid = true;
                        selectedMethod = method;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Invoice Details Section
                _buildInvoiceDetailsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Action Buttons Section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildActionButtonsSection(context),
          ),
        ],
      ),
    );
  }
}

  // Invoice Details Section
  Widget _buildInvoiceDetailsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Issued',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '5 may 2025',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  color: AppColors.blueGrey,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.extraLightGreyDivder),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Invoice #',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '003',
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  color: AppColors.blueGrey,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action Buttons Section
  Widget _buildActionButtonsSection(BuildContext context) {
    return Container(
      height: 176.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 17.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(Assets.imagesSvgShare),

                  Text(
                    'Share',
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(Assets.imagesSvgPrint),

                  Text(
                    'Print',
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(Assets.imagesSvgEdit),

                  Text(
                    'Edit',
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          FilledTextButton(
            onPressed: () {
              showDeleteInvoiceSheet(
                context,
                onDelete: () {
                  // Handle delete action here
                  Navigator.pop(context); // Close the bottom sheet
                  // You can also navigate back or show a confirmation message
                },
              );
            },
            text: "Send Invoice",
          ),
        ],
      ),
    );
  }


void showDeleteInvoiceSheet(BuildContext context, {VoidCallback? onDelete}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Spacer for rounded effect
            SizedBox(height: 12),
            // زر الحذف
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onDelete != null) onDelete();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: Color(0xFFFF0000),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.grey, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Delete Invoice",
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                    color: Color(0xFFFF0000),

                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // زر إلغاء
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: Color(0xFF94A3B8),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.grey, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: AppTextStyles.poFont20BlackWh600.copyWith(
                    color: Color(0xFF94A3B8),

                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
