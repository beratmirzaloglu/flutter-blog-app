// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  CategoryModel(this.id);

  CategoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
  }
}
