// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModel {
  String? id;
  FollowModel(this.id);
  FollowModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
  }
}
