import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/core/helpers/app_assets.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/core/widgets/outlined_text_button.dart';
import 'package:invoice_simple/features/dashboard/ui/cubit/invoice_dashboard_cubit.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/new_invoice_view.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_filter_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_invoice_tile.dart';
import 'package:svg_flutter/svg_flutter.dart';

class InvoiceDashboardViewBody extends StatelessWidget {
  const InvoiceDashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
            child: BlocBuilder<InvoiceDashboardCubit, int>(
              builder: (context, selectedFilter) {
                return Row(
                  children: [
                    CustomFilterButton(
                      label: 'All',
                      selected: selectedFilter == 0,
                      onTap: () =>
                          context.read<InvoiceDashboardCubit>().selectFilter(0),
                      textStyle: AppTextStyles.poFont20BlackWh300.copyWith(fontSize: 16.sp),
                    ),
                    const SizedBox(width: 10),
                    CustomFilterButton(
                      label: 'Outstanding',
                      selected: selectedFilter == 1,
                      onTap: () =>
                          context.read<InvoiceDashboardCubit>().selectFilter(1),
                      textStyle: AppTextStyles.poFont20BlackWh300.copyWith(fontSize: 16.sp),
                    ),
                    const SizedBox(width: 10),
                    CustomFilterButton(
                      label: 'Paid',
                      selected: selectedFilter == 2,
                      onTap: () =>
                          context.read<InvoiceDashboardCubit>().selectFilter(2),
                      textStyle: AppTextStyles.poFont20BlackWh300.copyWith(fontSize: 16.sp),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 26.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
            child: Column(
              children: const [
                CustomInvoiceTile(
                  circleText: 'J',
                  circleColor: AppColors.green,
                  title: 'John Doe',
                  subtitle: 'Invoice Complete',
                  trailing: '2 mins ago',
                ),
                CustomInvoiceTile(
                  circleText: 'R',
                  circleColor: AppColors.brown,
                  title: 'Rahul Enterproses',
                  subtitle: 'Received \$ 2,500.00',
                  trailing: 'Today',
                ),
                CustomInvoiceTile(
                  circleText: 'J',
                  circleColor: AppColors.violet,
                  title: 'John Doe',
                  subtitle: 'Invoice Complete',
                  trailing: 'May 15, 2025',
                ),
                CustomInvoiceTile(
                  circleText: 'V',
                  circleColor: AppColors.purple,
                  title: 'Verma Sons',
                  subtitle: 'Invoice Complete',
                  trailing: 'May 09, 2025',
                ),
              ],
            ),
          ),
          SizedBox(height: 26.h),
        Padding(
         padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
          child: FilledTextButton(
            onPressed: () =>context.push(NewInvoiceView.routeName),
            text:"Create Invoice" ),
        ),
          SizedBox(height: 8.h),
          Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingHorizontal),
            child: OutlinedTextButton(onPressed: () {}, text: "Create Estimates"),
          ),
            SizedBox(height: 75.h),
        ],
      ),
    );
  }
}