// Dart imports:
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/controllers/userController.dart';
import 'package:blogapp/models/category.dart';
import 'package:blogapp/models/follow.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/fcm_service.dart';
import 'package:blogapp/services/file.dart';
import 'package:blogapp/utils/static-functions.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user, File? profilePictureFile) async {
    try {
      if (profilePictureFile != null) {
        user.profilePicUrl = await FileService()
            .uploadProfilePicture(profilePictureFile, user.documentId!);
      }
      await _firestore.collection('users').doc(user.documentId).set({
        'email': user.email,
        'fullName': user.fullName,
        'profilePicUrl': user.profilePicUrl
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      return UserModel.fromSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void addPost(PostModel post) async {
    try {
      var userId = Get.find<AuthController>().user!.uid;
      await _firestore.collection('users').doc(userId).collection('posts').add({
        'postTitle': post.postTitle,
        'postCategory': post.postCategory,
        'postContent': post.postContent,
        'coverPhoto': post.coverPhoto,
        'createdAt': post.createdAt,
      });
      StaticFunctions.showInformation('Post added succesfully!');
    } catch (e) {
      print(e);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    try {
      var query = await _firestore.collection('categories').get();
      query.docs.forEach((c) {
        CategoryModel category = CategoryModel.fromDocumentSnapshot(c);
        categories.add(category);
      });
      print(query.docs);
      return categories;
    } catch (e) {
      print('hata!');
      print(e);
      return categories;
    }
  }

  Future<List<FollowModel>> getFollows(String userId) async {
    List<FollowModel> follows = [];
    try {
      var query = await _firestore
          .collection('users')
          .doc(userId)
          .collection('follows')
          .get();
      query.docs.forEach((c) {
        FollowModel follow = FollowModel.fromDocumentSnapshot(c);
        follows.add(follow);
      });
      return follows;
    } catch (e) {
      print(e);
      return follows;
    }
  }

  Future<List<PostModel>> getPostsByUserId(String userId) async {
    List<PostModel> posts = [];
    try {
      var query = await _firestore
          .collection('users')
          .doc(userId)
          .collection('posts')
          .get();

      await Future.forEach(query.docs, (DocumentSnapshot c) async {
        PostModel post = PostModel.fromSnapshot(c);
        UserModel author = await getPostAuthor(c);
        post.author = author;
        posts.add(post);
      });
      //  query.docs.forEach((c) async {
      //   PostModel post = PostModel.fromSnapshot(c);
      //   UserModel author = await getPostAuthor(c);
      //   post.author = author;
      //   posts.add(post);
      // });
      return posts;
    } catch (e) {
      print('HATA!!!!!!!');
      print(e);
      return posts;
    }
  }

  Stream<List<PostModel>> postStream() {
    return _firestore
        .collectionGroup('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(PostModel.fromSnapshot(element));
      });
      return retVal;
    });
  }

  Future<UserModel> getPostAuthor(DocumentSnapshot postDoc) async {
    var authorDocSnap = await postDoc.reference.parent.parent!.get();
    UserModel user = UserModel.fromSnapshot(authorDocSnap);
    return user;
  }

  Future<List<UserModel>> getListOfBloggers() async {
    List<UserModel> bloggers = [];
    try {
      var query = await _firestore.collection('users').get();

      query.docs.forEach((doc) {
        UserModel user = UserModel.fromSnapshot(doc);
        user.isFollowed = false;

        bloggers.add(user);
      });

      return bloggers;
    } catch (e) {
      print(e);
      return bloggers;
    }
  }

  followUser(String userId, bool isFollowing) async {
    var currentUserId = Get.find<AuthController>().user!.uid;
    var currentUserDocSnap =
        await _firestore.collection('users').doc(currentUserId).get();
    UserModel user = UserModel.fromSnapshot(currentUserDocSnap);
    try {
      if (isFollowing) {
        await _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('follows')
            .doc(userId)
            .delete();

        FcmService().sendNotificationToSpecificDevice(
            'Sorry:(', '${user.fullName}, unfollowed you!', userId);
      } else {
        await _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('follows')
            .doc(userId)
            .set({});

        FcmService().sendNotificationToSpecificDevice(
            'Congratz!', '${user.fullName} is now following you!', userId);
      }
    } catch (e) {
      print(e);
    }
  }

  addTokenToUser(String userId, String token) async {
    try {
      // await _firestore
      //     .collection('users')
      //     .doc(userId)
      //     .collection('tokens')
      //     .doc(token)
      //     .set({});

      await _firestore
          .collection('users')
          .doc(userId)
          .update({'device-token': token});
    } catch (e) {
      print(e);
    }
  }
}
