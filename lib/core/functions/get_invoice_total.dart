import 'package:invoice_simple/features/dashboard/data/models/invoice_model.dart';


double getInvoiceTotal(InvoiceModel invoice) {
  double subtotal = 0;

  for (final item in invoice.items) {
    final qty = item.quantity ?? 0;
    final price = item.unitPrice ?? 0;
    subtotal += price * qty;
  }

  return subtotal;
}




class InvoiceCalculationResult {
  final double subtotal;
  final double totalDiscount;
  final double totalTax;
  final double total;

  InvoiceCalculationResult({
    required this.subtotal,
    required this.totalDiscount,
    required this.totalTax,
    required this.total,
  });
}

InvoiceCalculationResult calculateInvoiceTotals(InvoiceModel invoice) {
  double subtotal = 0;
  double totalDiscount = 0;
  double totalTax = 0;

  for (final item in invoice.items) {
    final qty = item.quantity ?? 0;
    final price = item.unitPrice ?? 0;

    final amountBeforeDiscount = price * qty;

    final discountPercent = (item.discountActive) ? (item.discount ?? 0) : 0;
    final discountAmount = amountBeforeDiscount * (discountPercent / 100);

    final amountAfterDiscount = amountBeforeDiscount - discountAmount;

    final taxPercent = (item.taxable) ? (item.taxableAmount ?? 0) : 0;
    final itemTax = amountAfterDiscount * (taxPercent / 100);

    subtotal += amountBeforeDiscount;
    totalDiscount += discountAmount;
    totalTax += itemTax;
  }

  final total = subtotal - totalDiscount + totalTax;

  return InvoiceCalculationResult(
    subtotal: subtotal,
    totalDiscount: totalDiscount,
    totalTax: totalTax,
    total: total,
  );
}



// double getInvoiceTotal(InvoiceModel invoice) {
//   double subtotal = 0;
//   double totalDiscount = 0;
//   double totalTax = 0;

//   for (final item in invoice.items) {
//     final qty = item.quantity ?? 0;
//     final price = item.unitPrice ?? 0;

//     final amountBeforeDiscount = price * qty;
//     final discountPercent = (item.discountActive) ? (item.discount ?? 0) : 0;
//     final discountAmount = amountBeforeDiscount * (discountPercent / 100);
//     final amountAfterDiscount = amountBeforeDiscount - discountAmount;
//     final taxPercent = (item.taxable) ? (item.taxableAmount ?? 0) : 0;
//     final itemTax = amountAfterDiscount * (taxPercent / 100);

//     subtotal += amountBeforeDiscount;
//     totalDiscount += discountAmount;
//     totalTax += itemTax;
//   }

//   return subtotal - totalDiscount + totalTax;
// }

