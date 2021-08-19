// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blogapp/models/category.dart';
import 'package:blogapp/services/database.dart';

class CategoryController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  final _selectedCategory = ''.obs;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(value) => _selectedCategory.value = value;

  // ignore: invalid_use_of_protected_member
  List<CategoryModel> get categories => _categories.value;
  set categories(value) => _categories.value = value;

  void getCategories() async {
    isLoading = true;
    try {
      categories = await Database().getCategories();
      print('kategoriler çekildi');
      selectedCategory = categories[0].id;
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }
}
