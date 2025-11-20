// Receipt Page with PDF Print & Download
import 'package:flutter/material.dart';

class OnlineReceiptPage extends StatelessWidget {
  const OnlineReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;

    return Card(
      color: Colors.white,
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
          ],
        ),
      ),
    );
  }

  // ---------------- PDF GENERATION ----------------
}
