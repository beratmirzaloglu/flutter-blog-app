// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/userController.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/database.dart';
import 'package:blogapp/services/fcm_service.dart';
import 'package:blogapp/utils/static-functions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Giriş yap fonksiyonu
  void login(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await Database().getUser(user.user!.uid);
      FcmService().getTokenAndSave();
    } on FirebaseAuthException catch (e) {
      StaticFunctions.showError(e.message);
    }
  }

  // Kayıt ol fonksiyonu
  void createUser(String fullName, String email, String password,
      File? profilePictureFile) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // create a user in firestore
      UserModel _user = UserModel(
          documentId: user.user?.uid, email: email, fullName: fullName);
      if (await Database().createNewUser(_user, profilePictureFile)) {
        // user created succesfully
        Get.find<UserController>().user = _user;
        FcmService().getTokenAndSave();

        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      StaticFunctions.showError(e.message);
    }
  }

  // Çıkış yap fonksiyonu
  void logout() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      print(e);
    }
  }
}
