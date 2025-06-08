import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:invoice_simple/core/helpers/app_constants.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';
import 'package:invoice_simple/features/settings/ui/widgets/search_field.dart';




class AddItemViewBody extends StatefulWidget {
  const AddItemViewBody({
    super.key,
    required this.myController,
  });

  final TextEditingController myController;

  @override
  State<AddItemViewBody> createState() => _AddItemViewBodyState();
}

class _AddItemViewBodyState extends State<AddItemViewBody> {
  String searchText = '';

  @override
  void initState() {
    super.initState();
    widget.myController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchText = widget.myController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    widget.myController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: Column(
          children: [
            SearchField(
              controller: widget.myController,
              onChanged: (text) {
                // No need for setState here because listener handles it
              },
            ),
            SizedBox(height: 12.h),
            // Total price of all filtered items
            ValueListenableBuilder(
              valueListenable: Hive.box<ItemModel>(AppConstants.hiveItemBox).listenable(),
              builder: (context, Box<ItemModel> box, _) {
                final items = box.values.toList();
                final filtered = searchText.isEmpty
                    ? items
                    : items.where((item) =>
                        (item.name ?? '')
                            .toLowerCase()
                            .contains(searchText) ||
                        (item.details ?? '')
                            .toLowerCase()
                            .contains(searchText)
                      ).toList();

                double total = filtered.fold(
                  0.0,
                  (sum, item) =>
                      sum +
                      ((item.unitPrice ?? 0) *
                          ((item.quantity ?? 1).toDouble())),
                );
                return Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${total.toStringAsFixed(2)}\$',
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.blueGrey,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8.h),
            Container(height: 0.75.h, color: AppColors.blueGrey),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: Hive.box<ItemModel>(AppConstants.hiveItemBox).listenable(),
              builder: (context, Box<ItemModel> box, _) {
                final items = box.values.toList();

                final filtered = searchText.isEmpty
                    ? items
                    : items.where((item) =>
                        (item.name ?? '')
                            .toLowerCase()
                            .contains(searchText) ||
                        (item.details ?? '')
                            .toLowerCase()
                            .contains(searchText)
                      ).toList();

                if (filtered.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text("No items found.",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name ?? 'No Name',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.poFont20BlackWh400.copyWith(
                            fontSize: 14.sp,
                          )),
                        SizedBox(width: 8.w),
                        Text(
                          "${item.unitPrice?.toStringAsFixed(2) ?? "0.00"} \$",
                          style: AppTextStyles.poFont20BlackWh400.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.blueGrey,
                          ),
                        ),
                      ],         
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}