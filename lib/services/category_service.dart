import 'base_service.dart';
import '../models/category.dart';

class CategoryService extends BaseService {
  /// GET all categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get("/categories/");
      if (response.statusCode == 200 && response.data["success"] == true) {
        final List data = response.data["data"];
        return data.map((json) => Category.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Category error: $e");
      return [];
    }
  }

  /// POST create new category
  Future<Category?> createCategory(Category category) async {
    try {
      final response = await dio.post("/categories/", data: category.toJson());
      if (response.statusCode == 201) {
        return Category.fromJson(response.data["data"]);
      }
      return null;
    } catch (e) {
      print("Create category error: $e");
      return null;
    }
  }

  /// GET category by ID
  Future<Category?> getCategory(int id) async {
    try {
      final response = await dio.get("/categories/$id/");
      if (response.statusCode == 200) {
        return Category.fromJson(response.data["data"]);
      }
      return null;
    } catch (e) {
      print("Get category error: $e");
      return null;
    }
  }

  /// PATCH update category by ID
  Future<Category?> updateCategory(int id, Map<String, dynamic> updates) async {
    try {
      final response = await dio.patch("/categories/$id/", data: updates);
      if (response.statusCode == 200) {
        return Category.fromJson(response.data["data"]);
      }
      return null;
    } catch (e) {
      print("Update category error: $e");
      return null;
    }
  }

  /// DELETE category by ID
  Future<bool> deleteCategory(int id) async {
    try {
      final response = await dio.delete("/categories/$id/");
      return response.statusCode == 204;
    } catch (e) {
      print("Delete category error: $e");
      return false;
    }
  }
}
