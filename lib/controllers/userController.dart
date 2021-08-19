// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/controllers/followController.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/database.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  final _users = <UserModel>[].obs;

  UserModel get user => _userModel.value;
  set user(UserModel value) => this._userModel.value = value;

  // ignore: invalid_use_of_protected_member
  List<UserModel> get users => _users.value;
  set users(List<UserModel> value) => _users.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  getAllUsersAndMarkFollowings() async {
    users = await Database().getListOfBloggers();
    Get.find<FollowController>().follows.forEach((followUser) {
      users.firstWhere((user) => user.documentId == followUser.id).isFollowed =
          true;
    });
    print(users);
  }
}
