// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/views/main_screen.dart';
import 'package:blogapp/views/splash.dart';

class Root extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (_authController.user != null) ? MainScreenView() : SplashView();
    });
  }
}
