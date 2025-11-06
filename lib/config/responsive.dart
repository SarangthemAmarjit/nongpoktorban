import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  // screen sizes
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // screen sizes
  static bool isgalmob(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500 &&
      MediaQuery.of(context).size.width < 600;

  // screen sizes
  static bool issmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 500;

  // screen sizes
  static bool isMobtab(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000 &&
      MediaQuery.of(context).size.width >= 800;
  static bool isTabDesk(BuildContext context) =>
      MediaQuery.of(context).size.width < 1235 &&
      MediaQuery.of(context).size.width >= 1000;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;
  static bool isDesktopnew(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1445;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          return desktop;
        } else if (constraints.maxWidth >= 600) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
