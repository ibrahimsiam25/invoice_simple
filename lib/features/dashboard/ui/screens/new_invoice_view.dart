import 'package:flutter/material.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_new_inovice_view_app_bar.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/new_invoice_view_body.dart';

class NewInvoiceView extends StatelessWidget {
  const NewInvoiceView({super.key});
  static const String routeName = '/new-invoice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomNewInoviceViewAppBar(),
      body: NewInvoiceViewBody(),
    );
  }
}
