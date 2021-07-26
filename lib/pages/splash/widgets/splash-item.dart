import 'package:flutter/material.dart';

import 'package:blogapp/constants/asset_path.dart';

class SplashItem extends StatelessWidget {
  late final String imageText;
  late final String authorName;
  late final String circularPhoto;
  late final String slidePhoto;

  SplashItem({
    Key? key,
    required this.imageText,
    required this.authorName,
    required this.circularPhoto,
    required this.slidePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        slidePhoto,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Positioned(
        bottom: 50,
        child: Column(
          children: [
            Text(
              imageText,
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontFamily: 'Rubik'),
            ),
            Row(
              children: [
                ClipOval(
                  child: Image.asset(circularPhoto,
                      width: 50, height: 50, fit: BoxFit.cover),
                ),
                Text(authorName),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
