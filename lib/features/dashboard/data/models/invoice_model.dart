import 'package:hive/hive.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';

part 'invoice_model.g.dart';


@HiveType(typeId: 3)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  DateTime issuedDate;


  @HiveField(1)
  String invoiceNumber;

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

  InvoiceModel({
    required this.issuedDate,
  
    required this.invoiceNumber,
    required this.businessAccount,
    required this.client,
    required this.items,
    required this.total,
    required this.currency,
    required this.imagePath,
  });
}
     


