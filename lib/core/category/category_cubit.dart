import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/core/category/category_state.dart';
import 'package:mysmallshop/core/repository/categories_repo.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoriesRepository repository;
  CategoryCubit({required this.repository}) : super(CategoryLoading());

  void loadCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await repository.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
