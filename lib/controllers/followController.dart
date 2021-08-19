// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/models/follow.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/database.dart';

class FollowController extends GetxController {
  final _follows = <FollowModel>[].obs;
  final _followingPosts = <PostModel>[].obs;
  final _isLoading = false.obs;

  // ignore: invalid_use_of_protected_member
  List<FollowModel> get follows => _follows.value;
  set follows(List<FollowModel> value) => _follows.value = value;

  // ignore: invalid_use_of_protected_member
  List<PostModel> get followingPosts => _followingPosts.value;
  set followingPosts(List<PostModel> value) => _followingPosts.value = value;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  getFollows(bool isRefresh) async {
    isLoading = true;

    if (followingPosts.isEmpty || isRefresh) {
      if (isRefresh) followingPosts.clear();

      var userId = Get.find<AuthController>().user!.uid;
      follows = await Database().getFollows(userId);

      for (var follow in follows) {
        List<PostModel> posts =
            await Database().getPostsByUserId(follow.id.toString());
        _followingPosts.addAll(posts);
      }

      _followingPosts.sort((a, b) => -a.createdAt!.compareTo(b.createdAt!));

      isLoading = false;
    }
  }

  followUser(String userId, bool isFollowing) async {
    await Database().followUser(userId, isFollowing);
  }
}
