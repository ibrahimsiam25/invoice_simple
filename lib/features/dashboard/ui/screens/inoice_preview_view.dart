import 'package:flutter/widgets.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/custom_scaffold.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_new_inovice_view_app_bar.dart';

import 'package:flutter/material.dart';

// افترض أنك لديك هذه التعريفات في مشروعك
// import 'app_colors.dart';
// import 'app_text_styles.dart';
// import 'custom_scaffold.dart';
// import 'custom_new_invoice_view_app_bar.dart';

class InvoicePreviewView extends StatelessWidget {
  const InvoicePreviewView({super.key});
  static const String routeName = '/invoice-preview';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomNewInoviceViewAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Yulia Kartavenko",
                      style: AppTextStyles.poFont20BlackWh600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'INVOICE',
                        style: AppTextStyles.poFont20BlackWh600,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "#001",
                        style: AppTextStyles.poFont20BlackWh300.copyWith(
                          color: AppColors.grey.withOpacity(0.18),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Issued 05/05/2025",
                        style: AppTextStyles.poFont20BlackWh300.copyWith(
                          color: AppColors.grey,
                          fontSize: 16,
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
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    "BILL TO",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Ivan Ivanov",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // From name
              Text(
                "Yulia Kartavenko",
                style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 18),

              // Table Header Row
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
                        style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  Text(
                    "QTY",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14),
                  ),
                  Text(
                    "Price, UAH",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14),
                  ),
                  Text(
                    "Amount, UAH",
                    style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14),
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
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Text(
                        "Total",
                        style: AppTextStyles.poFont20BlackWh400.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.lightGrey, width: 1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(2),
                        ),
                      ),
                      child: Text(
                        "UAH 0.00",
                        style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // يمكنك إضافة المزيد هنا حسب الحاجة
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceTableRow extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool showTopBorder;
  final bool showBottomBorder;

  const InvoiceTableRow({
    super.key,
    required this.children,
    this.height = 44,
    this.textStyle,
    this.backgroundColor,
    this.showTopBorder = false,
    this.showBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: AppColors.lightGrey, width: 1);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        border: Border(
          top: showTopBorder ? borderSide : BorderSide.none,
          bottom: showBottomBorder ? borderSide : BorderSide.none,
        ),
      ),
      child: Row(
        children: List.generate(children.length, (index) {
          return Expanded(
            flex: index == 0 ? 6 : (index == 1 ? 2 : 3),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: (index != children.length - 1)
                      ? borderSide
                      : BorderSide.none,
                ),
              ),
              alignment: Alignment.center,
              child: children[index],
            ),
          );
        }),
      ),
    );
  }
}