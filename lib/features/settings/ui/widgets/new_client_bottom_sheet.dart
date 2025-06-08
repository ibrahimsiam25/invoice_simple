import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/core/widgets/filled_text_button.dart';
import 'package:invoice_simple/features/settings/ui/widgets/divider.dart';

class NewClientBottomSheet extends StatefulWidget {
  const NewClientBottomSheet({super.key});

  @override
  State<NewClientBottomSheet> createState() => _NewClientBottomSheetState();
}

class _NewClientBottomSheetState extends State<NewClientBottomSheet> {
  final TextEditingController billToController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
                        Navigator.pop(context);
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
                  controller: billToController,
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
                      // Name
                      _buildContactField("Name", nameController),
                      const SizedBox(height: 10),
                
                      // Phone
                      _buildContactField("Phone", phoneController),
                      const SizedBox(height: 10),
                
                      // Address
                      _buildContactField("Address", addressController),
                      const SizedBox(height: 10),
                
                      // Email
                      _buildContactField("E-mail", emailController),
                      const SizedBox(height: 20),
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

                  }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build contact fields
  Widget _buildContactField(String label, TextEditingController controller) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 85.w,
              child: Text(
                label,
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                style: AppTextStyles.poFont20BlackWh400.copyWith(
                  fontSize: 13,
                  color: AppColors.blueAccent,
                ),
                cursorColor: AppColors.blueAccent,
                decoration: InputDecoration(
                  hintText: "Optional",
                  hintStyle: AppTextStyles.poFont20BlackWh400.copyWith(
                    fontSize: 13,
                    color: AppColors.blueGrey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const CustomDivider(), // Assuming CustomDivider is defined elsewhere
      ],
    );
  }
}