import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_table_row.dart';

class InvoicePreviewViewBody extends StatelessWidget {
  const InvoicePreviewViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Yulia Kartavenko",
                      style: AppTextStyles.poFont20BlackWh600.copyWith(
                        fontSize: 14.sp
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'INVOICE',
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                        fontSize: 14.sp
                      ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "#001",
                        style: AppTextStyles.poFont20BlackWh400.copyWith(
                          color: AppColors.extraLightGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Issued 05/05/2025",
                        style: AppTextStyles.poFont20BlackWh400.copyWith(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // FROM - BILL TO
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "FROM",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "BILL TO",
                      style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Ivan Ivanov",
                   style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // From name
              Text(
                "Yulia Kartavenko",
                 style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 12.sp,
                    ),
              ),
              SizedBox(height: 5.h),
    
              InvoiceTableRow(
                backgroundColor: AppColors.lightGrey,
                height: 44,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Description",
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "QTY",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    "Price, UAH",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    "Amount, UAH",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(
                      fontSize: 10.sp,
    
                    ),
                  ),
                ],
              ),
              // Table Empty Row
              InvoiceTableRow(
                height: 44,
                showBottomBorder: true,
                children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
    
              // Total Row
              Row(
                children: [
                  Expanded(
                    flex: 6 + 2 + 3,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      child: Text(
                        "Total",
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(2),
                        ),
                      ),
                      child: Text(
                        "UAH 0.00",
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
          
            ],
          ),
        ),
      ),
    );
  }
}
