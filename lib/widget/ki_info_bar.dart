import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KIinfoBar extends StatelessWidget {
  final String title;
  final String message;
  final Color bgcolor;

  const KIinfoBar({
    required this.title,
    required this.message,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink(); // Return an empty SizedBox here
  }

  void showInfo() {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 3),
      backgroundColor: bgcolor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
    );
  }
}
