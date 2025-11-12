import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:torbanticketing/routes/app_bindings.dart';
import 'package:torbanticketing/routes/app_pages.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
    setPathUrlStrategy();
  runApp(const ParkTicketingApp());
}

class ParkTicketingApp extends StatelessWidget {
  const ParkTicketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kangla Nongpok Torban Ticketing',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: AppPages.pages,
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

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 1200,
  });

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
