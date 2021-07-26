import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/pages/home/home.dart';
import 'package:blogapp/pages/login/login.dart';
import 'package:blogapp/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(_authController.user);
      return (_authController.user != null) ? HomePage() : SplashPage();
    });
  }
}
