// Receipt Page with PDF Print & Download
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../main.dart';

class ReceiptPage extends StatelessWidget {
  final String name;
  final String mobile;
  final String address;

  final int adults;
  final int children;
  final double total;
  final String paymentMethod;

  const ReceiptPage({
    super.key,
    required this.name,
    required this.mobile,
    required this.address,
    required this.adults,
    required this.children,
    required this.total,
    required this.paymentMethod,
  });

  String _generateReceiptNumber() {
    return 'PKT${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;
    final receiptNo = _generateReceiptNumber();
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: ResponsiveCenter(
        maxWidth: isLargeScreen ? 900 : double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
              child: Column(
                children: [
                  // Success Icon
                  Container(
                    width: isLargeScreen ? 120 : 80,
                    height: isLargeScreen ? 120 : 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: isLargeScreen ? 70 : 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isLargeScreen ? 24 : 16),
                  Text(
                    'Payment Successful!',
                    style: TextStyle(
                      fontSize: isLargeScreen ? 36 : 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: isLargeScreen ? 12 : 8),
                  Text(
                    'Your tickets have been booked',
                    style: TextStyle(
                      fontSize: isLargeScreen ? 18 : 16,
                      color: const Color(0xFF757575),
                    ),
                  ),
                  SizedBox(height: isLargeScreen ? 40 : 32),

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
                          'Kangla Nongpok Torban Park',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 32 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Official Receipt',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 16 : 14,
                            color: const Color(0xFF757575),
                          ),
                        ),
                        SizedBox(height: isLargeScreen ? 32 : 24),

                        if (isLargeScreen)
                          _buildLargeScreenReceipt(receiptNo, now)
                        else
                          _buildMobileReceipt(receiptNo, now),

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
                                '₹${total.toStringAsFixed(0)}',
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
                      Expanded(
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
                            style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
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
    final now = DateTime.now();
    final receiptNo = _generateReceiptNumber();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Kangla Nongpok Torban Park',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'Official Receipt',
                  style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 10),
              _pdfRow('Receipt No:', receiptNo),
              _pdfRow('Date:', DateFormat('dd MMM yyyy, hh:mm a').format(now)),
              _pdfRow('Name:', name),
              _pdfRow('Mobile:', mobile),
              _pdfRow('Address:', address),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 10),
              _pdfRow(
                'Adults:',
                '$adults × ₹${adultPrice.toStringAsFixed(0)} = ₹${(adults * adultPrice).toStringAsFixed(0)}',
              ),
              _pdfRow(
                'Children:',
                '$children × ₹${childPrice.toStringAsFixed(0)} = ₹${(children * childPrice).toStringAsFixed(0)}',
              ),
              _pdfRow('Payment Method:', paymentMethod),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
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
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '₹${total.toStringAsFixed(0)}',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.green800,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Center(
                child: pw.Text(
                  'Please show this receipt at the park entrance',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.orange700,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Thank you for visiting Kangla Nongpok Torban Park!',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              label,
              style: pw.TextStyle(
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
              style: const pw.TextStyle(color: PdfColors.black),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UI BUILD HELPERS ----------------

  Widget _buildLargeScreenReceipt(String receiptNo, DateTime now) {
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
        const Divider(height: 32, thickness: 2),
        Row(
          children: [
            Expanded(child: _buildReceiptRow('Name:', name, false, true)),
            const SizedBox(width: 24),
            Expanded(child: _buildReceiptRow('Mobile:', mobile, false, true)),
          ],
        ),
        const SizedBox(height: 16),
        _buildReceiptRow('Address:', address, false, true),
        const Divider(height: 32, thickness: 2),
        Row(
          children: [
            Expanded(
              child: _buildReceiptRow(
                'Adults:',
                '$adults × ₹${adultPrice.toStringAsFixed(0)} = ₹${(adults * adultPrice).toStringAsFixed(0)}',
                false,
                true,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildReceiptRow(
                'Children:',
                '$children × ₹${childPrice.toStringAsFixed(0)} = ₹${(children * childPrice).toStringAsFixed(0)}',
                false,
                true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReceiptRow('Payment Method:', paymentMethod, false, true),
      ],
    );
  }

  Widget _buildMobileReceipt(String receiptNo, DateTime now) {
    return Column(
      children: [
        _buildReceiptRow('Receipt No:', receiptNo, true, false),
        _buildReceiptRow(
          'Booking Date:',
          '${DateFormat('dd MMM yyyy').format(now)} ${DateFormat('hh:mm a').format(now)}',
          false,
          false,
        ),
        _buildReceiptRow('Name:', name, false, false),
        _buildReceiptRow('Mobile:', mobile, false, false),
        _buildReceiptRow('Address:', address, false, false),
        _buildReceiptRow(
          'Adults:',
          '$adults × ₹${adultPrice.toStringAsFixed(0)} = ₹${(adults * adultPrice).toStringAsFixed(0)}',
          false,
          false,
        ),
        _buildReceiptRow(
          'Children:',
          '$children × ₹${childPrice.toStringAsFixed(0)} = ₹${(children * childPrice).toStringAsFixed(0)}',
          false,
          false,
        ),
        _buildReceiptRow('Payment Method:', paymentMethod, false, false),
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
