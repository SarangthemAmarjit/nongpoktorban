import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:torbanticketing/view/formpage.dart';

void main() {
  runApp(const ParkTicketingApp());
}

class ParkTicketingApp extends StatelessWidget {
  const ParkTicketingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adventure Park',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const TicketBookingScreen(),
    );
  }
}

// Constants
const double adultPrice = 500.0;
const double childPrice = 250.0;

// Responsive wrapper widget
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveCenter({Key? key, required this.child, this.maxWidth = 1200})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
