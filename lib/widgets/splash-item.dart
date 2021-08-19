// Flutter imports:
import 'package:flutter/material.dart';

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
        bottom: 60,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                imageText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontFamily: 'Rubik',
                    height: 1.4),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(circularPhoto,
                        width: 35, height: 35, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 15),
                  Text(
                    authorName,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF Compact Rounded',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ]);
  }
}
