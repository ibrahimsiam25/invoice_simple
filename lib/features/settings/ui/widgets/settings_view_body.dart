import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/features/settings/ui/widgets/settings_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingHorizontal, vertical: 10),
        child: Container(
          padding: EdgeInsets.only(
              left: 26.w, right: 26.w, top: 75.h, bottom: 12.h), 
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10), // أكثر تقوس مثل الصورة
          ),
          child: Column(
            children: [
              SettingsTile(title: "Business Information", onTap: () {}),
              SettingsTile(title: "Clients", onTap: () {}),
              SettingsTile(title: "Items", onTap: () {}),
              SettingsTile(isHaveIcon: false,title: "Privacy", onTap: () {}),
              SettingsTile(isHaveIcon: false,title: "Terms", onTap: () {}),
              SettingsTile(isHaveIcon: false,title: "Contact", onTap: () {}),
              SettingsTile(isHaveIcon: false,title: "Rate App", onTap: () {}),
              SettingsTile(isHaveIcon: false,title: "Share App", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
