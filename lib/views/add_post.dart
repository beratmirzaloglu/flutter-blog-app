// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// Project imports:
import 'package:blogapp/controllers/categoryController.dart';
import 'package:blogapp/controllers/postController.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/file.dart';
import 'package:blogapp/utils/static-functions.dart';

class AddPostView extends StatefulWidget {
  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final _postController = Get.find<PostController>();
  final _categoryController = Get.find<CategoryController>();
  final _postTitleController = TextEditingController();
  final _postContentController = TextEditingController();

  final _fileService = FileService();
  File? _coverPhotoForBlog;

  _addPostHandler() async {
    var title = _postTitleController.text;
    var category = _categoryController.selectedCategory;
    var content = _postContentController.text;
    String? coverPhotoUrl;
    if (_coverPhotoForBlog != null) {
      coverPhotoUrl =
          await _fileService.uploadCoverPhotoForBlog(_coverPhotoForBlog!);
    }

    PostModel post = PostModel(
        postTitle: title,
        postCategory: category,
        postContent: content,
        coverPhoto: coverPhotoUrl,
        createdAt: DateTime.now());

    _postController.addPost(post);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (_categoryController.categories.isEmpty) {
      _categoryController.getCategories();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.navigate_before,
            color: Colors.black,
            size: 40,
          ),
        ),
        title: Text(
          'Add Post',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _postTitleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => DropdownButton(
                  isExpanded: true,
                  onChanged: (String? value) {
                    _categoryController.selectedCategory = value ?? '';
                  },
                  value: _categoryController.selectedCategory,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: _categoryController.categories
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.id.toString()),
                        ),
                      )
                      .toList(),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _postContentController,
              maxLines: 8,
              decoration: InputDecoration(hintText: 'Content'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[500],
              ),
              onPressed: _showChoiceDialog,
              child: Text('Upload Cover Photo'),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  _coverPhotoForBlog == null
                      ? 'No image'
                      : basename(_coverPhotoForBlog!.path),
                ),
                Visibility(
                  visible: _coverPhotoForBlog != null,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _coverPhotoForBlog = null;
                      });
                    },
                    child: Text('X'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _addPostHandler,
              child: Text('Add Post'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,
                    40), // double.infinity is the width and 30 is the height
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _openCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        if (pickedFile != null) {
          _coverPhotoForBlog = File(pickedFile.path);
        }
      });
      print(pickedFile);
    } catch (e) {
      StaticFunctions.showError(
          'Kamera açılamadı. Lütfen gerekli izinleri kontrol ediniz.');
    }
  }

  void _openGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _coverPhotoForBlog = File(pickedFile.path);
      }
    });
  }

  void _showChoiceDialog() async {
    await Get.defaultDialog(
      title: 'Source',
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                _openGallery();
                Get.back();
              },
              title: Text("Gallery"),
              leading: Icon(
                Icons.account_box,
                color: Colors.blue,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () async {
                _openCamera();
                Get.back();
              },
              title: Text("Camera"),
              leading: Icon(
                Icons.camera,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
