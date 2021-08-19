// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:blogapp/constants/asset_path.dart';
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/utils/static-functions.dart';

class LoginView extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
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
              Text('Welcome\nBack.',
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
                  hintText: 'Password',
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
                onPressed: () => _loginButtonClickHandler(
                    _emailController.text, _passwordController.text),
                color: Colors.red[600],
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'OR',
                    style: TextStyle(fontSize: 16),
                  )),
              MaterialButton(
                onPressed: _twitterLoginButtonClickHandler,
                color: HexColor('#3BBCF8'),
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      twitterLogo,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign in with Twitter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: _facebookLoginButtonClickHandler,
                color: HexColor('#3B5998'),
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      facebookLogo,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign in with Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _signUpButtonClickHandler,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New User? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      ' Sign Up',
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

  void _loginButtonClickHandler(String email, String password) {
    if (!GetUtils.isEmail(email)) {
      StaticFunctions.showError('Please enter a valid email adress.');
      return;
    }
    _authController.login(email, password);
  }

  void _twitterLoginButtonClickHandler() {
    print('twitter login button clicked!');
  }

  void _facebookLoginButtonClickHandler() {
    print('facebook login button clicked!');
  }

  void _signUpButtonClickHandler() {
    Get.toNamed('/signup');
  }
}
