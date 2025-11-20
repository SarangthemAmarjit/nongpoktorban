// Receipt Page with PDF Print & Download
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/controller/managementcontroller.dart';
import 'package:torbanticketing/controller/pagecon.dart';

import '../main.dart';

class OfflineReceiptPage extends StatelessWidget {
  const OfflineReceiptPage({super.key});

  String _generateReceiptNumber() {
    return 'KNT${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
  }

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 160;
    double mmToDp(double mm) => (mm / 25.4) * dpi; // DPI of screen
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;
    final receiptNo = _generateReceiptNumber();
    final now = DateTime.now();
    Managementcontroller managementcontroller =
        Get.find<Managementcontroller>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: ResponsiveCenter(
        maxWidth: isLargeScreen ? 900 : double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
          child: Padding(
            padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
            child: Column(
              children: [
                // Receipt Details
                Container(
                  padding: EdgeInsets.all(isLargeScreen ? 32 : 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 3),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.confirmation_number,
                        size: isLargeScreen ? 50 : 40,
                        color: const Color(0xFF4CAF50),
                      ),
                      SizedBox(height: isLargeScreen ? 16 : 12),
                      Text(
                        textAlign: TextAlign.center,
                        'Kangla Nongpok Torban Park',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 32 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'E - Ticket Receipt',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
                          color: const Color(0xFF757575),
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 32 : 24),

                      if (isLargeScreen)
                        _buildLargeScreenReceipt(
                          receiptNo,
                          now,
                          managementcontroller,
                        )
                      else
                        _buildMobileReceipt(
                          receiptNo,
                          now,
                          managementcontroller,
                        ),

                      SizedBox(height: isLargeScreen ? 32 : 24),
                      Container(
                        padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE8F5E9), Color(0xFFE3F2FD)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Paid:',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 24 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹${managementcontroller.totalamount.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 36 : 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 32 : 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.amber[800],
                              size: isLargeScreen ? 32 : 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please show this receipt at the park entrance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isLargeScreen ? 16 : 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.amber[900],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Thank you for visiting Kangla Nongpok Torban Park!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isLargeScreen ? 14 : 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isLargeScreen ? 40 : 24),

                // Action Buttons
                Row(
                  children: [
                    // Download PDF
                    iskiosk || isofflinepay
                        ? SizedBox()
                        : Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await _generateAndDownloadPdf(context);
                              },
                              icon: Icon(
                                Icons.download,
                                size: isLargeScreen ? 24 : 20,
                              ),
                              label: Text(
                                'Download',
                                style: TextStyle(
                                  fontSize: isLargeScreen ? 18 : 16,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: isLargeScreen ? 20 : 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: const BorderSide(
                                  color: Color(0xFF2196F3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(width: isLargeScreen ? 24 : 16),

                    // Print PDF
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await _generateAndPrintPdf(context);
                        },
                        icon: Icon(
                          Icons.print,
                          color: Colors.white,
                          size: isLargeScreen ? 24 : 20,
                        ),
                        label: Text(
                          'Print',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isLargeScreen ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          padding: EdgeInsets.symmetric(
                            vertical: isLargeScreen ? 20 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                    SizedBox(width: isLargeScreen ? 24 : 16),

                    // Home / Book Another
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.find<Pagemanagementcontroller>().resetPage();
                          managementcontroller.resetcount();
                          Get.toNamed('/');
                        },
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: isLargeScreen ? 24 : 20,
                        ),
                        label: Text(
                          'Book Another',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isLargeScreen ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: EdgeInsets.symmetric(
                            vertical: isLargeScreen ? 20 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- PDF GENERATION ----------------

  Future<void> _generateAndPrintPdf(BuildContext context) async {
    final pdf = await _buildPdfDocument();
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = await _buildPdfDocument();
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'receipt.pdf');
  }

  Future<pw.Document> _buildPdfDocument() async {
    final pdf = pw.Document();
    final ttf = pw.Font.ttf(
      await rootBundle.load("assets/fonts/NotoSans-Regular.ttf"),
    );
    final now = DateTime.now();
    final receiptNo = _generateReceiptNumber();
    Managementcontroller managementcontroller =
        Get.find<Managementcontroller>();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.symmetric(horizontal: 25),

        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  textAlign: pw.TextAlign.center,
                  'Kangla Nongpok Torban Park',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'E - Ticket Receipt',
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                ),
              ),
              pw.SizedBox(height: 1),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 1),
              _pdfRow('Receipt No:', receiptNo, ttf),
              _pdfRow(
                'Date:',
                DateFormat('dd MMM yyyy, hh:mm a').format(now),
                ttf,
              ),
              _pdfRow(
                'Name:',
                managementcontroller.visitorDetails?.name ?? '',
                ttf,
              ),
              _pdfRow(
                'Mobile:',
                managementcontroller.visitorDetails?.phone ?? '',
                ttf,
              ),
              _pdfRow(
                'Address:',
                managementcontroller.visitorDetails?.address ?? '',
                ttf,
              ),
              pw.SizedBox(height: 1),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 1),
              managementcontroller.visitorDetails?.adultCount == 0
                  ? pw.SizedBox()
                  : _pdfRow(
                      'Adults:',
                      '${managementcontroller.visitorDetails?.adultCount ?? 0} × ₹${managementcontroller.adultrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.adultCount ?? 0) * managementcontroller.adultrate).toStringAsFixed(0)}',
                      ttf,
                    ),
              managementcontroller.visitorDetails?.childCount == 0
                  ? pw.SizedBox()
                  : _pdfRow(
                      'Children:',
                      '${managementcontroller.visitorDetails?.childCount ?? 0} × ₹${managementcontroller.childrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.childCount ?? 0) * managementcontroller.childrate).toStringAsFixed(0)}',
                      ttf,
                    ),
              _pdfRow('Payment Mode:', 'Cash', ttf),
              pw.SizedBox(height: 1),
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(8),
                  color: PdfColors.green100,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total Paid:',
                      style: pw.TextStyle(
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '₹${managementcontroller.totalamount.toStringAsFixed(0)}',
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.green800,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 3),
              pw.BarcodeWidget(
                barcode: pw.Barcode.code128(),
                data: receiptNo,
                width: 300,

                height: 50,
                drawText: true,
                textPadding: 2,

                textStyle: pw.TextStyle(fontSize: 12, letterSpacing: 8),
              ),
              pw.SizedBox(height: 3),
              pw.Center(
                child: pw.Text(
                  textAlign: pw.TextAlign.center,
                  'Please show this receipt at the park entrance',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.orange700,
                  ),
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 15),
                child: pw.Center(
                  child: pw.Text(
                    textAlign: pw.TextAlign.center,
                    'Thank you for visiting Kangla Nongpok Torban Park!',
                    style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
                  ),
                ),
              ),
              pw.Container(color: PdfColors.grey300, height: 2),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _pdfRow(String label, String value, pw.Font tt) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey800,
              ),
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(
                fontSize: 8,

                color: PdfColors.black,
                font: tt,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UI BUILD HELPERS ----------------

  Widget _buildLargeScreenReceipt(
    String receiptNo,
    DateTime now,
    Managementcontroller managementcontroller,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildReceiptRow('Receipt No:', receiptNo, true, true),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildReceiptRow(
                'Date & Time:',
                '${DateFormat('dd MMM yyyy').format(now)}\n${DateFormat('hh:mm a').format(now)}',
                false,
                true,
              ),
            ),
          ],
        ),
        const Divider(height: 20, thickness: 2),
        Row(
          children: [
            Expanded(
              child: _buildReceiptRow(
                'Name:',
                managementcontroller.visitorDetails?.name ?? '',
                false,
                true,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildReceiptRow(
                'Mobile:',
                managementcontroller.visitorDetails?.phone ?? '',
                false,
                true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReceiptRow(
          'Address:',
          managementcontroller.visitorDetails?.address ?? '',
          false,
          true,
        ),
        const Divider(height: 20, thickness: 2),
        Row(
          children: [
            managementcontroller.visitorDetails?.adultCount == 0
                ? SizedBox()
                : Expanded(
                    child: _buildReceiptRow(
                      'Adults:',
                      '${managementcontroller.visitorDetails?.adultCount ?? 0} × ₹${managementcontroller.adultrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.adultCount ?? 0) * managementcontroller.adultrate).toStringAsFixed(0)}',
                      false,
                      true,
                    ),
                  ),
            const SizedBox(width: 24),
            managementcontroller.visitorDetails?.childCount == 0
                ? SizedBox()
                : Expanded(
                    child: _buildReceiptRow(
                      'Children:',
                      '${managementcontroller.visitorDetails?.childCount ?? 0} × ₹${managementcontroller.childrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.childCount ?? 0) * managementcontroller.childrate).toStringAsFixed(0)}',
                      false,
                      true,
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReceiptRow('Payment Mode:', 'Cash', false, true),
      ],
    );
  }

  Widget _buildMobileReceipt(
    String receiptNo,
    DateTime now,
    Managementcontroller managementcontroller,
  ) {
    return Column(
      children: [
        _buildReceiptRow('Receipt No:', receiptNo, true, false),
        _buildReceiptRow(
          'Booking Date:',
          '${DateFormat('dd MMM yyyy').format(now)} ${DateFormat('hh:mm a').format(now)}',
          false,
          false,
        ),
        _buildReceiptRow(
          'Name:',
          managementcontroller.visitorDetails?.name ?? '',
          false,
          false,
        ),
        _buildReceiptRow(
          'Mobile:',
          managementcontroller.visitorDetails?.phone ?? '',
          false,
          false,
        ),
        _buildReceiptRow(
          'Address:',
          managementcontroller.visitorDetails?.address ?? '',
          false,
          false,
        ),
        managementcontroller.visitorDetails?.adultCount == 0
            ? SizedBox()
            : _buildReceiptRow(
                'Adults:',
                '${managementcontroller.visitorDetails?.adultCount ?? 0} × ₹${managementcontroller.adultrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.adultCount ?? 0) * managementcontroller.adultrate).toStringAsFixed(0)}',
                false,
                false,
              ),
        managementcontroller.visitorDetails?.childCount == 0
            ? SizedBox()
            : _buildReceiptRow(
                'Children:',
                '${managementcontroller.visitorDetails?.childCount ?? 0} × ₹${managementcontroller.childrate.toStringAsFixed(0)} = ₹${((managementcontroller.visitorDetails?.childCount ?? 0) * managementcontroller.childrate).toStringAsFixed(0)}',
                false,
                false,
              ),
        _buildReceiptRow('Payment Mode:', 'Cash', false, false),
      ],
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value,
    bool isHighlighted,
    bool isLarge,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: isLarge ? 1 : 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isLarge ? 16 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: isLarge ? 1 : 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: isLarge ? 16 : 14,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                color: isHighlighted
                    ? const Color(0xFF2196F3)
                    : const Color(0xFF212121),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
