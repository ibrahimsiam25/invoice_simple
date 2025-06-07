import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/features/settings/data/model/currency_model.dart';

class CurrencyBottomSheet extends StatelessWidget {
  final List<CurrencyModel> items;
  final CurrencyModel selected;

  const CurrencyBottomSheet({
    required this.items,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mostRecent = items.firstWhere(
      (c) => c.code == selected.code,
      orElse: () => items.first,
    );

    return SafeArea(
      child: Container(
        
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFD8D8D8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
      
            // Title bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24, color: Colors.black),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Currency',
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                          fontSize: 26.sp,
                         
                      ),)
                    ),
                  ),
                  // Invisible for symmetry
                  Opacity(
                    opacity: 0,
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
            ),
      
            // Most recent label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Most recent',
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                    fontSize: 12.sp,
                    color: AppColors. blueGrey 
                  ),
                ),
              ),
            ),
      
            // Most recent selected currency
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, ),
              child: InkWell(
                onTap: () => Navigator.pop(context, mostRecent),
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                  
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text(
                        mostRecent.code,
                        style: AppTextStyles.poFont20BlackWh600.copyWith(
                          fontSize: 12.sp,
                      
                        ),
                      ),
                         SizedBox(width: 2.w),
                      if (mostRecent.code == selected.code)
      
                        Icon(Icons.check, size: 18.sp, color: AppColors.black),
                     Spacer(),
                      Text(
                        mostRecent.name,
                     style: AppTextStyles.poFont20BlackWh400.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.blueGrey,
                      
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
      
         
            Padding(         
              padding:  EdgeInsets.only(left: 24.w, top: 18,),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All currencies',
                  style: AppTextStyles.poFont20BlackWh400.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.blueGrey,
      
                        ),
                ),
              ),
            ),
       SizedBox(
              height: 8.h,
       ),
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: 24.w),
           child: Divider(
                color: AppColors.extraLightGreyDivder,
                height: 1,
              ),
         ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
          
                itemBuilder: (context, index) {
                  final currency = items[index];
                  return InkWell(
                    onTap: () => Navigator.pop(context, currency),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              currency.code,
                             style: AppTextStyles.poFont20BlackWh400.copyWith(
                          fontSize: 14.sp,
                        
                        ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              currency.name,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.poFont20BlackWh400.copyWith(
                                fontSize: 14.sp,
                                
                                color: AppColors.blueGrey,
                                    
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
