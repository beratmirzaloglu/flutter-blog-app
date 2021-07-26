import 'package:blogapp/services/authService.dart';
import 'package:blogapp/utils/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthService _authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String fullName, String email, String password) {
    _authService.signup(fullName, email, password);
    Get.offAll(Root());
  }

  void login(String email, String password) {
    _authService.login(email, password);
    Get.offAll(Root());
  }

  void logout() {
    print("authController.logout() fired!");
    _authService.logout();
  }
}
