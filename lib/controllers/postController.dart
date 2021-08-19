// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/models/post.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/database.dart';

class PostController extends GetxController {
  final _selectedPost = PostModel().obs;
  final _selectedUser = UserModel().obs;

  get selectedPost => _selectedPost.value;
  set selectedPost(value) => _selectedPost.value = value;

  get selectedUser => _selectedUser.value;
  set selectedUser(value) => _selectedUser.value = value;

  addPost(PostModel post) async {
    Database().addPost(post);
  }
}
