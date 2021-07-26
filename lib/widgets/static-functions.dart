import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticFunctions {
  static showError(message) {
    return Get.snackbar('Error', message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.error),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.grey[200],
        colorText: Colors.black,
        margin: EdgeInsets.all(30));
  }
}
