import 'package:flutter/material.dart';
import 'package:invoice_simple/core/di/dependency_injection.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/features/dashboard/ui/cubit/invoice_dashboard_cubit.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_dashboard_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class InvoiceDashboardView extends StatelessWidget {
  const InvoiceDashboardView({super.key});
  static const String routeName = '/invoice-dashboard';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InvoiceDashboardCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: InvoiceDashboardViewBody(),
      ),
    );
  }
}
