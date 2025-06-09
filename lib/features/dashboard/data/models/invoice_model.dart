import 'package:hive/hive.dart';
import 'package:invoice_simple/features/dashboard/ui/widgets/invoice_header_section.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';

part 'invoice_model.g.dart';


@HiveType(typeId: 3)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  DateTime issuedDate;


  @HiveField(1)
 int invoiceNumber;

  @HiveField(2)
  BusinessUserModel businessAccount;

  @HiveField(3)
  ClientModel client;

  @HiveField(4)
  List<ItemModel> items;

  @HiveField(5)
  double total;

  @HiveField(6)
  String currency;

  @HiveField(7)
  String imagePath;
@HiveField(8)
String? paymentMethod;


  InvoiceModel({
    required this.issuedDate,
  
    required this.invoiceNumber,
    required this.businessAccount,
    required this.client,
    required this.items,
    required this.total,
    required this.currency,
    required this.imagePath,
    this.paymentMethod,
  });
  InvoiceModel copyWith({
    DateTime? issuedDate,
    int? invoiceNumber,
    BusinessUserModel? businessAccount,
    ClientModel? client,
    List<ItemModel>? items,
    double? total,
    String? currency,
    String? imagePath,
    String? paymentMethod,
  }) {
    return InvoiceModel(
      issuedDate: issuedDate ?? this.issuedDate,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      businessAccount: businessAccount ?? this.businessAccount,
      client: client ?? this.client,
      items: items ?? this.items,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      imagePath: imagePath ?? this.imagePath,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
     


