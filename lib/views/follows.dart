// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/followController.dart';
import 'package:blogapp/controllers/userController.dart';

final Image noImage = Image.network(
    "https://www.invenura.com/wp-content/themes/consultix/images/no-image-found-360x250.png");

class FollowsView extends StatefulWidget {
  @override
  _BookmarksViewState createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<FollowsView> {
  final UserController _userController = Get.find<UserController>();
  final FollowController _followController = Get.find<FollowController>();

  _onTapHandler(index) {
    var isFollowing = _userController.users[index].isFollowed;
    _followController.followUser(
        _userController.users[index].documentId!, isFollowing ?? false);

    setState(() {
      _userController.users[index].isFollowed = !isFollowing!;
    });
  }

  @override
  void initState() {
    super.initState();
    print('initstate');
    _userController.getAllUsersAndMarkFollowings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'You can follow this bloggers: ',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: _userController.users.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () => _onTapHandler(index),
                        title: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: ClipOval(
                                child: Image.network(
                                    _userController
                                            .users[index].profilePicUrl ??
                                        '',
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            (loadingProgress == null)
                                                ? child
                                                : CircularProgressIndicator(),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            noImage),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(_userController.users[index].fullName!),
                          ],
                        ),
                        trailing: _userController.users[index].isFollowed!
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                      );
                    }),
              )),
        ],
      )),
    );
  }
}
