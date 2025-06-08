
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/build_message_bar.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/core/widgets/show_required_fields_dialog.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/ui/widgets/labeled_text_field.dart';
class NewClientBottomSheet extends StatefulWidget {
  const NewClientBottomSheet({super.key});

  @override
  State<NewClientBottomSheet> createState() => _NewClientBottomSheetState();
}

class _NewClientBottomSheetState extends State<NewClientBottomSheet> {


 String billTo = "",
      clientName = "",
      clientPhone = "",
      clientEmail = "",
      clientAddress = "";
      
  Future<void> saveClient() async {
    // Check if any required field is empty
    if (billTo.trim().isEmpty ||
        clientName.trim().isEmpty ||
        clientPhone.trim().isEmpty ||
        clientAddress.trim().isEmpty) {
        showRequiredFieldsDialog(context, "Please fill all required fields");
      return;
    }

    final newClient = ClientModel(
      billTo: billTo.trim(),
      clientName: clientName.trim(),
      clientPhone: clientPhone.trim(),
      clientAddress: clientAddress.trim(),
      clientEmail: clientEmail.trim(),
    );

    final box = await Hive.openBox<ClientModel>(AppConstants.hiveClientBox);
    await box.add(newClient);

    if (!mounted) return;
    for (var client in box.values) {
      print('Client: ${client.clientName}, Phone: ${client.clientPhone} '
          'Address: ${client.clientAddress}, Email: ${client.clientEmail}'
          ', Bill To: ${client.billTo}-----------' );
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Client saved successfully!")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85, 
      ),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: AppTextStyles.poFont20BlackWh400.copyWith(fontSize: 14.sp),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        saveClient();
                      }, 
                      child: Text(
                        "Done",
                        style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                
                // Header
                Text(
                  "New Client",
                  style: AppTextStyles.poFont20BlackWh600.copyWith(fontSize: 26.sp),
                ),
                SizedBox(height: 23),
                
                // Bill To field
                TextField(
                  onChanged: (value) => billTo = value,
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.blueAccent,
                  ),
                  cursorColor: AppColors.blueAccent,
                  decoration: InputDecoration(
                    hintText: "Bill To",
                    hintStyle: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.blueGrey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Contacts section header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Contacts",
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.blueGrey,
                    ),
                  ),
                ),
                
                // Contacts form
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Column(
                    children: [
                        LabeledTextField(
                  label: 'Name',
                  onChanged: (val) => clientName = val?? "",
                  hintText: 'Must be filled',
                ),
                LabeledTextField(
                  label: 'Phone',
                  onChanged: (val) => clientPhone = val?? "",
                  hintText: 'Must be filled',
                  keyboardType: TextInputType.phone,
                ),
                LabeledTextField(
                  label: 'Address',
                  onChanged: (val) => clientAddress = val?? "",
                  hintText: 'Must be filled',
                ),
                LabeledTextField(
                  label: 'E-Mail',
                  onChanged: (val) => clientEmail = val?? "",
                  hintText: 'Optional',
                  keyboardType: TextInputType.emailAddress,
                ),
                    ],
                  ),
                ),
                
              SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric( vertical: 9.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5.r),
                
                  ),
                  child: Center(
                    child: Text(
                      "Import from Contacts",
                      style: AppTextStyles.poFont20BlackWh400.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
  FilledTextButton(
    color: AppColors.blue,
    text: "Continue", onPressed: () {
      saveClient();
    }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
