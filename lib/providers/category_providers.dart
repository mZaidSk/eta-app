import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../services/category_service.dart';

/// ---- STATE ----
class CategoriesState {
  final AsyncValue<List<Category>> categories;

  CategoriesState({
    this.categories = const AsyncValue.loading(),
  });

  CategoriesState copyWith({
    AsyncValue<List<Category>>? categories,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
    );
  }
}

/// ---- NOTIFIER ----
class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoryService service;

  CategoriesNotifier(this.service) : super(CategoriesState()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final data = await service.getCategories();
      state = state.copyWith(categories: AsyncValue.data(data));
    } catch (e, st) {
      state = state.copyWith(categories: AsyncValue.error(e, st));
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      final newCategory = await service.createCategory(category);
      if (newCategory != null) {
        final current = state.categories.value ?? [];
        state = state.copyWith(
          categories: AsyncValue.data([...current, newCategory]),
        );
      }
    } catch (e, st) {
      state = state.copyWith(categories: AsyncValue.error(e, st));
    }
  }

  Future<void> updateCategory(int id, Map<String, dynamic> updates) async {
    try {
      final updated = await service.updateCategory(id, updates);
      if (updated != null) {
        final current = state.categories.value ?? [];
        final newList = current.map((c) => c.id == id ? updated : c).toList();
        state = state.copyWith(categories: AsyncValue.data(newList));
      }
    } catch (e, st) {
      state = state.copyWith(categories: AsyncValue.error(e, st));
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final success = await service.deleteCategory(id);
      if (success) {
        final current = state.categories.value ?? [];
        final newList = current.where((c) => c.id != id).toList();
        state = state.copyWith(categories: AsyncValue.data(newList));
      }
    } catch (e, st) {
      state = state.copyWith(categories: AsyncValue.error(e, st));
    }
  }
}

/// ---- PROVIDERS ----
final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});

final categoriesNotifierProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final service = ref.watch(categoryServiceProvider);
  return CategoriesNotifier(service);
});
