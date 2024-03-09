import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        colorText: Colors.greenAccent.withOpacity(0.9),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  static error({required String msg}) {
    Get.snackbar('Error', msg,
        colorText: Colors.redAccent.withOpacity(0.9),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg,
        colorText: Colors.white,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }
}
