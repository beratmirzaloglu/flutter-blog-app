import 'package:blogapp/constants/asset_path.dart';
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/pages/login/login.dart';
import 'package:blogapp/widgets/static-functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SignupPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text('Create\nAccount.',
                  style: TextStyle(
                    fontSize: 36,
                  )),
              Container(
                width: 50,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.red, width: 3))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              TextField(
                controller: _fullNameController,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Create Password',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                alignment: Alignment.bottomRight,
                child: Text('Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () => _signUpButtonClickHandler(
                    _fullNameController.text,
                    _emailController.text,
                    _passwordController.text),
                color: Colors.red[600],
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _navigateToLoginPage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      ' Login',
                      style:
                          TextStyle(color: HexColor('#F71735'), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLoginPage() {
    Get.to(LoginPage());
  }

  void _signUpButtonClickHandler(
      String fullName, String email, String password) {
    if (!GetUtils.isEmail(email)) {
      StaticFunctions.showError('Please enter a valid email adress.');
      return;
    }
    _authController.createUser(fullName, email, password);
  }
}
