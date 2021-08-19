// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? documentId;
  String? email;
  String? fullName;
  String? profilePicUrl;
  String? deviceToken;
  bool? isFollowed;

  UserModel(
      {this.documentId,
      this.email,
      this.fullName,
      this.profilePicUrl,
      this.deviceToken});

  UserModel.fromSnapshot(DocumentSnapshot doc) {
    documentId = doc.id;
    email = doc.get('email');
    fullName = doc.get('fullName');
    profilePicUrl = doc.get('profilePicUrl');
    profilePicUrl = doc.get('device-token');
  }
}
