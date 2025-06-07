import 'package:flutter/material.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/ui/widgets/business_user.dart';

class BusinessViewBody extends StatelessWidget {
  const BusinessViewBody({
    super.key,
    required this.users,
  });

  final List<BusinessUserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
   
      itemBuilder: (context, index) => BusinessUser(
        user: users[index],
      ),
    );
  }
}
