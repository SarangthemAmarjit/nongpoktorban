import 'package:flutter/material.dart';
import 'package:torbanticketing/config/const.dart';

class Custombutton extends StatelessWidget {
  final String buttonname;
  final double? horizontalpadding;
  final double? verticalpadding;
  final bool? issubmitbutton;
  final void Function()? onPressed;
  const Custombutton({
    super.key,
    this.onPressed,
    required this.buttonname,
    this.horizontalpadding,
    this.verticalpadding,
    this.issubmitbutton,
  });

  @override
  Widget build(BuildContext context) {
    // final AdminController admicon = Get.put(AdminController());
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: commonbluecolor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalpadding ?? 32,
          vertical: verticalpadding ?? 16,
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonname, style: TextStyle(color: commonbluecolor)),
    );
  }
}
