// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:blogapp/controllers/categoryController.dart';
import 'package:blogapp/controllers/followController.dart';
import 'package:blogapp/controllers/postController.dart';
import 'package:blogapp/models/post.dart';

final Image noImage = Image.network(
    "https://www.invenura.com/wp-content/themes/consultix/images/no-image-found-360x250.png");

class LatestFeed extends StatefulWidget {
  @override
  _LatestFeedState createState() => _LatestFeedState();
}

class _LatestFeedState extends State<LatestFeed> {
  final firestore = FirebaseFirestore.instance;

  final _followController = Get.find<FollowController>();
  final _categoryController = Get.find<CategoryController>();
  final _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _followController.getFollows(true);
  }

  void _onRefresh() async {
    await _followController.getFollows(true);
    _categoryController.getCategories();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_followController.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (_followController.followingPosts.isEmpty) {
        return Center(
          child: Text(
            'No posts found.\nYou should follow some of our bloggers!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        return Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            onRefresh: _onRefresh,
            child: ListView.separated(
              itemCount: _followController.followingPosts.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildPostItem(
                      context, _followController.followingPosts[index]),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                endIndent: 16,
                indent: 16,
              ),
            ),
          ),
        );
      }
    });
  }
}

Widget _buildPostItem(BuildContext context, PostModel post) {
  final _postController = Get.find<PostController>();

  return InkWell(
    onTap: () {
      _postController.selectedUser = post.author;
      _postController.selectedPost = post;
      // Get.to(() => PostDetailView());
      Get.toNamed('/post-detail');
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  child: ClipOval(
                    child: Image.network(post.author?.profilePicUrl ?? '',
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : CircularProgressIndicator(),
                        errorBuilder: (context, error, stackTrace) => noImage),
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author?.fullName ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                        DateFormat.yMd('tr-TR')
                            .add_Hm()
                            .format(post.createdAt!),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ],
            ),
            Icon(Icons.more_vert),
          ],
        ),
        SizedBox(height: 30),
        Text(
          post.postTitle ?? '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                (post.coverPhoto ?? ' '),
                loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : CircularProgressIndicator(),
                errorBuilder: (context, error, stackTrace) => noImage,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(6),
                child: Text(
                  post.postCategory ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
