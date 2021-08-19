// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:blogapp/models/user.dart';

class PostModel {
  String? documentId;
  String? postTitle;
  String? postContent;
  String? postCategory;
  String? coverPhoto;
  DateTime? createdAt;
  UserModel? author;

  PostModel(
      {this.documentId,
      this.postTitle,
      this.postContent,
      this.postCategory,
      this.coverPhoto,
      this.createdAt,
      this.author});

  PostModel.fromSnapshot(DocumentSnapshot doc) {
    documentId = doc.id;
    postTitle = doc['postTitle'];
    postContent = doc['postContent'];
    postCategory = doc['postCategory'];
    coverPhoto = doc['coverPhoto'];
    createdAt = doc['createdAt'].toDate();
  }
}
