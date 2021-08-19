// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/services/fcm_service.dart';
import 'package:blogapp/widgets/latest-feed.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Latest Feed',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'SF Compact Rounded',
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
            child: FloatingActionButton(
              heroTag: 'logout',
              backgroundColor: HexColor('#F71735'),
              mini: true,
              onPressed: _authController.logout,
              child: Icon(
                Icons.logout,
                size: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
            child: FloatingActionButton(
              heroTag: 'add-post',
              backgroundColor: HexColor('#F71735'),
              mini: true,
              onPressed: () {
                // Get.to(() => AddPostView());
                Get.toNamed('/add-post');
              },
              child: Icon(
                Icons.add,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LatestFeed(),
          ],
        ),
      ),
    );
  }
}
