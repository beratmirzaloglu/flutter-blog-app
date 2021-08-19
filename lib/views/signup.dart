// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/utils/static-functions.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _profilePictureFile;

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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                ),
                onPressed: _showChoiceDialog,
                child: Text('Upload Profile Picture'),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    _profilePictureFile == null
                        ? 'No image'
                        : basename(_profilePictureFile!.path),
                  ),
                  Visibility(
                    visible: _profilePictureFile != null,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _profilePictureFile = null;
                        });
                      },
                      child: Text('X'),
                    ),
                  ),
                ],
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
                onPressed: _signUpButtonClickHandler,
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

  void _openCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        if (pickedFile != null) {
          _profilePictureFile = File(pickedFile.path);
        }
      });
      print(pickedFile);
    } catch (e) {
      StaticFunctions.showError(
          'Kamera açılamadı. Lütfen gerekli izinleri kontrol edin.');
    }
  }

  void _openGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _profilePictureFile = File(pickedFile.path);
      }
    });
  }

  void _showChoiceDialog() async {
    await Get.defaultDialog(
      title: 'Source',
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                _openGallery();
                Get.back();
              },
              title: Text("Gallery"),
              leading: Icon(
                Icons.account_box,
                color: Colors.blue,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () async {
                _openCamera();
                Get.back();
              },
              title: Text("Camera"),
              leading: Icon(
                Icons.camera,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLoginPage() {
    // Get.to(() => LoginView());
    Get.toNamed('/login');
  }

  bool validate() {
    if (!_emailController.text.isEmail) {
      StaticFunctions.showError('Please enter a valid email adress.');
      return false;
    }

    if (_fullNameController.text.isEmpty) {
      StaticFunctions.showError('Please enter a valid full name.');
      return false;
    }

    if (_passwordController.text.isEmpty) {
      StaticFunctions.showError('Please enter a valid password.');
      return false;
    }

    if (_passwordController.text.length < 6) {
      StaticFunctions.showError('Password can\'t be less than 6 characters.');
      return false;
    }

    return true;
  }

  void _signUpButtonClickHandler() {
    if (validate()) {
      _authController.createUser(_fullNameController.text,
          _emailController.text, _passwordController.text, _profilePictureFile);
    }
  }
}
