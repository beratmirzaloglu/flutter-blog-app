// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:blogapp/constants/asset_path.dart';
import 'package:blogapp/widgets/splash-item.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ImageSlideshow(
          width: double.infinity,
          height: double.infinity,
          initialPage: 0,
          indicatorColor: Colors.transparent,
          indicatorBackgroundColor: Colors.transparent,
          children: [
            SplashItem(
              authorName: 'John Doe',
              circularPhoto: personStock1,
              imageText: 'The Future of\nPhotography\n& Unsplash',
              slidePhoto: stockPhoto1,
            ),
            SplashItem(
              authorName: 'Mark Vera',
              circularPhoto: personStock2,
              imageText: 'The Future of\nPhotography\n& Unsplash',
              slidePhoto: stockPhoto2,
            ),
            SplashItem(
              authorName: 'George Wash',
              circularPhoto: personStock3,
              imageText: 'The Future of\nPhotography\n& Unsplash',
              slidePhoto: stockPhoto3,
            ),
          ],
          onPageChanged: (value) {},
          autoPlayInterval: 5000,
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MaterialButton(
                  onPressed: _loginButtonClickHandler,
                  color: HexColor('#FFFFFF'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minWidth: MediaQuery.of(context).size.width * 0.43,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: _createAccountButtonClickHandler,
                color: HexColor('#F71735'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                minWidth: MediaQuery.of(context).size.width * 0.5,
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
    // Get.to(() => LoginView());
    Get.toNamed('/login');
  }

  void _createAccountButtonClickHandler() {
    // Get.to(() => SignUpView());
    Get.toNamed('/signup');
  }
}
