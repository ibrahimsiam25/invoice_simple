import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/core/helpers/app_assets.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/helpers/shared_pref_helper.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/build_message_bar.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/dashboard/data/models/invoice_model.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_details_view.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/add_row_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_select_item.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_header_row.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/section_label.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/summary_row.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_clients_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_item_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/business_view.dart';
import 'package:svg_flutter/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class NewInvoiceViewBody extends StatefulWidget {
  const NewInvoiceViewBody({super.key});

  @override
  State<NewInvoiceViewBody> createState() => _NewInvoiceViewBodyState();
}

class _NewInvoiceViewBodyState extends State<NewInvoiceViewBody> {
  String invoiceNumber = "001";
   double totalAmount = 0.0;
  BusinessUserModel? selectedBusiness;
  ClientModel? selectedClient;
  List<ItemModel> selectedItems = [];
  String currency = "USA";
@override
void initState() {
  super.initState();
    print("*********************************initState called");
  _loadInvoiceData();
}

 Future<void> _loadInvoiceData() async {
   int count  = await SharedPrefHelper.getInt(AppConstants.prefsInvoiceNumber);
  if (count == 0) {
    count = 1;
  }
  final invNumber = count.toString().padLeft(3, '0');

  if (mounted) {
    setState(() {  
      invoiceNumber = invNumber;
    });
  }
}
  void updateTotalAmount() {
   
      totalAmount = selectedItems.fold(
        0.0,
        (sum, item) => sum + ((item.unitPrice ?? 0) * (item.quantity ?? 1)),
      );
 
  }
  void _saveInvoiceData() async {
  if (selectedBusiness == null ||
      selectedClient == null ||
      selectedItems.isEmpty) {
    buildMessageBar(context, "Please fill all required fields.");
    return;
  }

  final box = await Hive.openBox<InvoiceModel>(AppConstants.hiveInvoiceBox);

  double total = selectedItems.fold(
    0.0,
    (sum, item) => sum + ((item.unitPrice ?? 0) * (item.quantity ?? 1)),
  );

  final newInvoice = InvoiceModel(
    issuedDate: DateTime.now(),
    invoiceNumber: invoiceNumber,
    businessAccount: selectedBusiness!,
    client: selectedClient!,
    items: selectedItems,
    total: total,
    currency: currency,
    imagePaths: [], 
  );

  await box.add(newInvoice);
SharedPrefHelper.setData(
    AppConstants.prefsInvoiceNumber,
    int.parse(invoiceNumber) + 1,
  );
  buildMessageBar(context, "Invoice saved successfully!", );

}

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

            InvoiceHeaderRow(
              issued: DateFormat("d MMM yyyy").format(DateTime.now()),
              due: "-",
              number: invoiceNumber,
            ),
            SizedBox(height: 18),
            // Business Account
            SectionLabel(label: 'Business account'),
            if (selectedBusiness == null)
              AddRowButton(
                text: "Choose Account",
                onTap: () {
                  context.push(
                    BusinessView.routeName,
                    extra: (BusinessUserModel business) {
                      setState(() {
                        currency = business.currency;
                        selectedBusiness = business;
                      });
                    },
                  );
                },
              )
            else
              CustomSelectItem(
                text: selectedBusiness!.name,
                onPressed: () {
                  setState(() {
                    currency = "USA";
                    selectedBusiness = null;
                  });
                },
              ),

            SizedBox(height: 10),
            // Client
            SectionLabel(label: 'Client'),
           if (selectedClient == null)
              AddRowButton(
                text: "Add Client",
                onTap: () {
                  context.push(
                    AddClientsView.routeName,
                    extra: (ClientModel client) {
                      setState(() {
                        
                        selectedClient = client;
                      });
                    },
                  );
                },
              )
            else
              CustomSelectItem(
                text: selectedClient!.clientName,
                onPressed: () {
                  setState(() {
                    selectedClient = null;
                  });
                },
              ),
            SizedBox(height: 10),
            // Items
            SectionLabel(label: 'Items'),
            if (selectedItems.isEmpty)
              AddRowButton(
                text: "Add Item",
                onTap: () {
                  context.push(
                    AddItemView.routeName,
                    extra: (List<ItemModel> item) {
                      setState(() {
                     
                        selectedItems.addAll(item);
                          updateTotalAmount();
                      });
                    },
                  );
                },
              )
            else
              Column(
                children: selectedItems.map((item) {
                  return CustomSelectItem(
                    text: item.name ?? 'Unknown Item',
                    onPressed: () {
                      setState(() {
                        selectedItems.remove(item);
                            updateTotalAmount();

                      });
                    },
                  );
                }).toList(),
              ),
            SizedBox(height: 14),
            // Summary
            SectionLabel(label: 'Summary'),
            SummaryRow(currency: currency, totalAmount: totalAmount),
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
            FilledTextButton(
              text: "Create New Invoice",
              onPressed: () {
                _saveInvoiceData();
               // context.push(InvoiceDetailsView.routeName);
              },
            ),
            SizedBox(height: 68.h),
          ],
        ),
      ),
    );
  }
}
