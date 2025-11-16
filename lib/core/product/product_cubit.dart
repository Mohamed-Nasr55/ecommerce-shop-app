import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/core/repository/product_repo.dart';
import 'product_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository repository;
  ProductCubit({required this.repository}) : super(ProductLoading());

  List<Product> allProducts = [];

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      allProducts = await repository.fetchProducts();
      emit(ProductLoaded(allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  List<Product> filterByCategory(int categoryId) {
    return allProducts.where((p) => p.categoryId == categoryId).toList();
  }
}
