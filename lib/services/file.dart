// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart';

// Project imports:
import 'package:blogapp/utils/static-functions.dart';

import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
// For Image Picker

class FileService {
  Future<String?> uploadProfilePicture(File image, String userId) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref('profile-pictures/$userId');

      await storageReference.putFile(image);

      var fileUrl = await storageReference.getDownloadURL();
      return fileUrl;
    } catch (e) {
      StaticFunctions.showError(e);
    }
  }

  Future<String?> uploadCoverPhotoForBlog(File image) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref('cover-photos/${basename(image.path)}');

      await storageReference.putFile(image);

      var fileUrl = await storageReference.getDownloadURL();
      return fileUrl;
    } catch (e) {
      StaticFunctions.showError(e);
    }
  }

  Future<String?> getProfileImageUrl(String userId) async {
    try {
      String downloadURL = await FirebaseStorage.instance
          .ref('profile-pictures/$userId')
          .getDownloadURL();
      return downloadURL;
    } catch (e) {
      StaticFunctions.showError(e);
    }
  }
}
