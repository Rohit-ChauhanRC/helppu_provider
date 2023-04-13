import 'package:get/get.dart';

import '../models/category_model.dart';
import '../providers/laravel_provider.dart';

class CategoryRepository {
  LaravelApiClient _laravelApiClient;

  CategoryRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<Category>> getAll() {
    return _laravelApiClient.getAllCategories();
  }

  Future<List<Category>> getCatServiceAll() {
    return _laravelApiClient.getAllServiceCategories();
  }

  Future<List<Category>> getAllParents() {
    return _laravelApiClient.getAllParentCategories();
  }

  Future<List<Category>> getAllWithSubCategories() {
    return _laravelApiClient.getAllWithSubCategories();
  }

  Future<List<Category>> getUserSelectedSubCategories(id) {
    return _laravelApiClient.getUserSelectedSubCategories(id);
  }

  Future<List<Category>> getUserSelecteProducts(category_id, subcategory_id) {
    return _laravelApiClient.getUserSelectedProducts(
        category_id, subcategory_id);
  }

  Future<List<Category>> getAllSubCategories(params) {
    return _laravelApiClient.getAllSubCategories(params);
  }
}
