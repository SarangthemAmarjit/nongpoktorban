import 'dart:math';

import 'package:flutter/material.dart';

String baseapi = "https://imphalsmartcity.in/api";

const isofflinepay = false;
const iskiosk = true;

String generateReceiptNumber() {
  return 'KNT${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
}

const commonbluecolor = Color.fromARGB(255, 1, 45, 82);
String generateRandomString(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  return List.generate(
    length,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}

Map<String, dynamic> paymentmethod = {
  "DC": "Debit Card",
  "NB": "Net Banking",
  "CC": "Credit Card",
  "MW": "Wallet",
  "PP": "PhonePe",
  "PW": "Paytm Wallet",
  "EM": "EMI",
  "NR": "Challan",
  "BQ": "BharatQR",
  "UP": "Unified Payment Interface",
};

bool isDebugmode = false;
