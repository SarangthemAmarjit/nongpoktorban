import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Code128Example extends StatelessWidget {
  const Code128Example({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: data,
      width: 400,

      height: 130,
      drawText: true,
      textPadding: 12,

      style: TextStyle(fontSize: 22, letterSpacing: 8),
    );
  }
}
