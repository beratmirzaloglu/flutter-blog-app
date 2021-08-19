// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
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

  static showInformation(message) {
    return Get.snackbar('Information', message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.error),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.green[200],
        colorText: Colors.black,
        margin: EdgeInsets.all(30));
  }
}
