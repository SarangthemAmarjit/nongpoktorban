import 'package:flutter/material.dart';

Widget buildPriceCard(String title, double price, Color color, bool isLarge) {
  return Container(
    padding: EdgeInsets.all(isLarge ? 24 : 16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.3), width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              title.contains('Adult') ? Icons.person : Icons.child_care,
              color: color,
              size: isLarge ? 28 : 24,
            ),
            SizedBox(width: isLarge ? 16 : 12),
            Text(
              title,
              style: TextStyle(
                fontSize: isLarge ? 20 : 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF212121),
              ),
            ),
          ],
        ),
        Text(
          '₹${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isLarge ? 26 : 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}
