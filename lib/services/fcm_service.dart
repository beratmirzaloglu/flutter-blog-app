// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/database.dart';

class FcmService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void getTokenAndSave() {
    var userId = Get.find<AuthController>().user!.uid;
    _firebaseMessaging.getToken().then((token) {
      if (token != null) Database().addTokenToUser(userId, token);
    });
  }

  void sendNotificationToSpecificDevice(
      String title, String content, String userId) async {
    var serverKey =
        'AAAA6nu2RFI:APA91bGWhtA8k0Jpq4NLSi0Uz1HFyw3j5oa4wQdyNfeM-XmWIBOCUru09BrEQkFD7hZvcPbrNBExd-LrY4QcqW1ZxhF41rokZx-BrJFak3lmtPlp3hmkDrKAWVrMSTR8oczbYJMvIL_w';
    DocumentSnapshot docRef =
        await _firestore.collection('users').doc(userId).get();

    UserModel user = UserModel.fromSnapshot(docRef);

    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': content, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': user.deviceToken,
          },
        ),
      );
      print(response);
    } catch (e) {
      print("error push notification");
    }
  }
}
