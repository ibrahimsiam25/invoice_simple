import 'package:intl/intl.dart';
import 'package:invoice_simple/features/dashboard/data/models/invoice_model.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateInvoicePdf(InvoiceModel invoice) async {
  final pdf = pw.Document();

  final totalAmount = invoice.items.fold<double>(0, (sum, item) {
    final qty = item.quantity ?? 0;
    final price = item.unitPrice ?? 0;
    return sum + (qty * price);
  });

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(5),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 23),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header Row (Business name and Invoice number/date)
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        invoice.businessAccount.name,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'INVOICE',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "#${invoice.invoiceNumber.toString().padLeft(3, '0')}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.blueGrey,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Issued ${DateFormat('dd/MM/yyyy').format(invoice.issuedDate)}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 32),

                // FROM - BILL TO Row
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "FROM",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      "BILL TO",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    pw.Text(
                      invoice.client.clientName,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 8),

                // Business name (FROM)
                pw.Text(
                  invoice.businessAccount.name,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 8),

                // Table header
                pw.Container(
                  color: PdfColors.grey300,
                  height: 44,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        flex: 4,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                          child: pw.Text(
                            "Name",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Center(
                          child: pw.Text(
                            "QTY",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Center(
                          child: pw.Text(
                            "Price, ${invoice.currency}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Center(
                          child: pw.Text(
                            "Amount, ${invoice.currency}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Items rows
                ...invoice.items.map((item) {
                  final qty = item.quantity ?? 0;
                  final price = item.unitPrice ?? 0;
                  final amount = qty * price;

                  return pw.Container(
                    height: 44,
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
                      ),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          flex: 4,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                            child: pw.Text(
                              item.name ?? '',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Center(
                            child: pw.Text(
                              qty.toString(),
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Center(
                            child: pw.Text(
                              price.toStringAsFixed(2),
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Center(
                            child: pw.Text(
                              amount.toStringAsFixed(2),
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // Total row
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 9,
                      child: pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          border: pw.Border.all(color: PdfColors.grey300, width: 1),
                          borderRadius: const pw.BorderRadius.only(
                            bottomRight: pw.Radius.circular(2),
                          ),
                        ),
                        child: pw.Text(
                          "${invoice.currency} ${totalAmount.toStringAsFixed(2)}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    ),
  );

  // حفظ الملف مثلا في جهازك:
  final file = File('invoice.pdf');
  await file.writeAsBytes(await pdf.save());
}


