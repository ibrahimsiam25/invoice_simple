import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_assets.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class InvoiceDashboardView extends StatefulWidget {
  const InvoiceDashboardView({super.key});
  static const String routeName = '/invoice-dashboard';
  @override
  State<InvoiceDashboardView> createState() => _InvoiceDashboardViewState();
}

class _InvoiceDashboardViewState extends State<InvoiceDashboardView> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Column(
        children: [
      
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Income',
                            style: AppTextStyles.poFont20BlackWh400.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Text(
                            '\$ 27,000.00',
                            style: AppTextStyles.moFont20BlackWh500.copyWith(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(Assets.imagesSvgSettings),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

        SizedBox(height: 26.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
            child: Row(
              children: [
                _buildFilterButton('All', 0, selected: selectedFilter == 0),
                const SizedBox(width: 10),
                _buildFilterButton(
                  'Outstanding',
                  1,
                  selected: selectedFilter == 1,
                ),
                const SizedBox(width: 10),
                _buildFilterButton('Paid', 2, selected: selectedFilter == 2),
              ],
            ),
          ),
         SizedBox(height: 26.h),

          // Recent Invoices List
          Expanded(
            child: ListView(
              padding:  EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
              children: [
                _buildInvoiceTile(
                  circleText: 'J',
                  circleColor: AppColors.green,
                  title: 'John Doe',
                  subtitle: 'Invoice Complete',
                  trailing: '2 mins ago',
                ),
                _buildInvoiceTile(
                  circleText: 'R',
                  circleColor: AppColors.brown,
                  title: 'Rahul Enterproses',
                  subtitle: 'Received \$ 2,500.00',
                  trailing: 'Today',
                ),
                _buildInvoiceTile(
                  circleText: 'J',
                  circleColor: AppColors.violet,
                  title: 'John Doe',
                  subtitle: 'Invoice Complete',
                  trailing: 'May 15, 2025',
                ),
                _buildInvoiceTile(
                  circleText: 'V',
                  circleColor: AppColors.purple,
                  title: 'Verma Sons',
                  subtitle: 'Invoice Complete',
                  trailing: 'May 09, 2025',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, int index, {bool selected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = index;
          });
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(6),

            border: Border.all(
              color:
                  selected
                      ? AppColors.primary
                      : AppColors.grey.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.poFont20BlackWh300.copyWith(
                fontSize: 16.sp,
                color: selected ? Colors.white : AppColors.grey
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceTile({
    required String circleText,
    required Color circleColor,
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Card(
     
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: circleColor,
          radius: 28.r,
          child: Text(
            circleText,
            style: AppTextStyles.poFont20BlackWh600
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14.sp),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.poFont20BlackWh400.copyWith(fontSize: 12.sp),
        ),
        trailing: Text(
          trailing,
          style: AppTextStyles.poFont20BlackWh400.copyWith(
            fontSize: 12.sp,
            color: AppColors.grey,
          ),
        ),
      ),
    );
  }
}
