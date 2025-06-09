import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/helpers/shared_pref_helper.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/build_message_bar.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/dashboard/data/models/invoice_model.dart';
import 'package:invoice_simple/features/dashboard/ui/cubit/business_cubit.dart';
import 'package:invoice_simple/features/dashboard/ui/cubit/client_cubit.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/inoice_preview_view.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/add_row_button.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/custom_select_item.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_header_row.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/new_invoice_add_photo.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/section_label.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/summary_row.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_clients_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_item_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/business_view.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class NewInvoiceViewBody extends StatefulWidget {
  const NewInvoiceViewBody({super.key, });
 
  @override
  State<NewInvoiceViewBody> createState() => NewInvoiceViewBodyState();
}
 
class NewInvoiceViewBodyState extends State<NewInvoiceViewBody> {
  String invoiceNumber = "001";
   double totalAmount = 0.0;
  BusinessUserModel? selectedBusiness;
  ClientModel? selectedClient;
  List<ItemModel> selectedItems = [];
  File? logoImage; 
  String currency = "USA";
  void onPreview() {
      if (selectedBusiness == null ||
      selectedClient == null ||
      selectedItems.isEmpty) {
    buildMessageBar(context, "Please fill all business Account , Client and Items.");
    return;
  }
  context.push(InvoicePreviewView.routeName, extra: InvoiceModel(
    issuedDate: DateTime.now(),
    invoiceNumber: invoiceNumber,
    businessAccount: selectedBusiness!,
    client: selectedClient!,
    items: selectedItems,
    total: totalAmount,
    currency: currency,
    imagePath: logoImage?.path ?? '',
  ));
  }
  void onDone() {
    _saveInvoiceData();
  }
@override
void initState() {
  super.initState();
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
    buildMessageBar(context, "Please fill all business Account , Client and Items.");
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
    imagePath: logoImage?.path ?? '',
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

BlocBuilder<BusinessCubit, BusinessState>(
  builder: (context, state) {

    if (state.selectedBusiness == null) {

      return AddRowButton(
        text: "Choose Account",
        onTap: () async {
          final cubit = context.read<BusinessCubit>();
          final business = await context.push<BusinessUserModel>(
            BusinessView.routeName,
            extra: true, 
          );

          if (business != null) {
            cubit.selectBusiness(business);
          }
        },
      );
    } else {
       
      return CustomSelectItem(
        text: state.selectedBusiness!.name,
        onPressed: () {
          context.read<BusinessCubit>().clearBusiness();
        },
      );
    }
  },
)

,

            SizedBox(height: 10),
            // Client
            SectionLabel(label: 'Client'),
          BlocBuilder<ClientCubit, ClientState>(
  builder: (context, state) {
    if (state.selectedClient == null) {
      return AddRowButton(
        text: "Add Client",
        onTap: () async {
          final cubit = context.read<ClientCubit>();
          final client = await context.push<ClientModel>(
            AddClientsView.routeName,
            extra: true,
          );

          if (client != null) {
            cubit.selectClient(client);
          }
        },
      );
    } else {
      return CustomSelectItem(
        text: state.selectedClient!.clientName,
        onPressed: () {
          context.read<ClientCubit>().clearClient();
        },
      );
    }
  },
)
,
            SizedBox(height: 10),







            // Items
            SectionLabel(label: 'Items'),





            
       BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              if (state.selectedItems.isEmpty) {
                return AddRowButton(
                  text: "Add Items",
                  onTap: () async {
                    final cubit = context.read<ItemsCubit>();
                    
                    final selectedItems = await context.push<List<ItemModel>>(
                      AddItemView.routeName,
                      extra: true, // clickable = true
                    );
                    
                    if (selectedItems != null && selectedItems.isNotEmpty) {
                      cubit.addItems(selectedItems);
                    }
                  },
                );
              } else {
                return Column(
                  children: [
                    // Display selected items
                    Column(
                      children: state.selectedItems.map((item) {
                        return CustomSelectItem(
                          text: item.name ?? 'Unknown Item',
                          onPressed: () {
                            context.read<ItemsCubit>().removeItem(item);
                          },
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: 10),
                    
                    // Add another items button
                    AddRowButton(
                      text: "Add another Items",
                      onTap: () async {
                        final cubit = context.read<ItemsCubit>();
                        
                        final selectedItems = await context.push<List<ItemModel>>(
                          AddItemView.routeName,
                          extra: true, // clickable = true
                        );
                        
                        if (selectedItems != null && selectedItems.isNotEmpty) {
                          cubit.addItems(selectedItems);
                        }
                      },
                    ),
                  ],
                );
              }
            },
          ),
          
          // Total Amount Display
          BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              final total = context.read<ItemsCubit>().getTotalAmount();
              return Text(
                'Total: ${total.toStringAsFixed(2)}\$',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            },
          ),




            SizedBox(height: 14),
            // Summary
            SectionLabel(label: 'Summary'),

BlocBuilder<BusinessCubit, BusinessState>(
  builder: (context, state) {
    return SummaryRow(currency: state.currency, totalAmount: totalAmount);
  },
)
,
            SizedBox(height: 14),
            // Photos
            SectionLabel(label: 'Photos'),
          NewInvoiceAddPhoto(
             onImageSelected: (image) {
            
                setState(() {
                  logoImage = image;
                });
              },
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






class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit() : super(ItemsState.initial());

  void addItems(List<ItemModel> items) {
    final updatedItems = List<ItemModel>.from(state.selectedItems);
    updatedItems.addAll(items);
    emit(state.copyWith(selectedItems: updatedItems));
  }

  void removeItem(ItemModel item) {
    final updatedItems = List<ItemModel>.from(state.selectedItems);
    updatedItems.remove(item);
    emit(state.copyWith(selectedItems: updatedItems));
  }

  void clearAllItems() {
    emit(state.copyWith(selectedItems: []));
  }

  double getTotalAmount() {
    return state.selectedItems.fold(
      0.0,
      (sum, item) => sum + ((item.unitPrice ?? 0) * (item.quantity ?? 1)),
    );
  }
}


class ItemsState {
  final List<ItemModel> selectedItems;

  const ItemsState({required this.selectedItems});

  factory ItemsState.initial() {
    return const ItemsState(selectedItems: []);
  }

  ItemsState copyWith({
    List<ItemModel>? selectedItems,
  }) {
    return ItemsState(
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
