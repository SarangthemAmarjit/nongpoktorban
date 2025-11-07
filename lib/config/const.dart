import 'dart:math';

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
