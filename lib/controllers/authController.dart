// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/services/auth.dart';
import 'package:blogapp/utils/root.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String fullName, String email, String password,
      File? profilePictureFile) async {
    AuthService().createUser(fullName, email, password, profilePictureFile);
    Get.offAll(() => Root());
  }

  void login(String email, String password) async {
    AuthService().login(email, password);
    Get.offAll(() => Root());
  }

  void logout() {
    AuthService().logout();
  }
}
