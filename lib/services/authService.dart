import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/widgets/static-functions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Giriş yap fonksiyonu
  Future<User?> login(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException catch (e) {
      StaticFunctions.showError(e.message);
    }
  }

  // Kayıt ol fonksiyonu
  Future<User?> signup(String fullName, String email, String password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("users").doc(user.user?.uid).set({
        'fullName': fullName,
        'email': email,
      });
      return user.user;
    } on FirebaseAuthException catch (e) {
      StaticFunctions.showError(e.message);
    }
  }

  // Çıkış yap fonksiyonu
  logout() async {
    return await _auth.signOut();
  }
}
