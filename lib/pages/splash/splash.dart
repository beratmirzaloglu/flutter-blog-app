import 'package:blogapp/constants/asset_path.dart';
import 'package:blogapp/pages/login/login.dart';
import 'package:blogapp/pages/signup/signup.dart';
import 'package:blogapp/pages/splash/widgets/splash-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ImageSlideshow(
          /// Width of the [ImageSlideshow].
          width: double.infinity,

          /// Height of the [ImageSlideshow].
          height: double.infinity,

          /// The page to show when first creating the [ImageSlideshow].
          initialPage: 0,

          /// The color to paint the indicator.
          indicatorColor: Colors.blue,

          /// The color to paint behind th indicator.
          indicatorBackgroundColor: Colors.grey,

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: [
            SplashItem(
              authorName: 'John Doe',
              circularPhoto: personStock1,
              imageText: 'The Future of\nPhotography\n& Unsplash',
              slidePhoto: stockPhoto1,
            ),
          ],

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
            print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 3000,
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: _loginButtonClickHandler,
                color: HexColor('#FFFFFF'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                minWidth: MediaQuery.of(context).size.width * 0.48,
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              MaterialButton(
                onPressed: _createAccountButtonClickHandler,
                color: HexColor('#F71735'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                minWidth: MediaQuery.of(context).size.width * 0.48,
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _loginButtonClickHandler() {
    Get.to(LoginPage());
  }

  void _createAccountButtonClickHandler() {
    Get.to(SignupPage());
  }
}
