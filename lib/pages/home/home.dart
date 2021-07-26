import 'package:blogapp/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("HOME PAGE"),
          ),
          MaterialButton(
            onPressed: _authController.logout,
            child: Text('Logout'),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
