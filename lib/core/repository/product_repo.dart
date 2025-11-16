import 'package:dio/dio.dart';
import 'package:mysmallshop/core/product/product_model.dart';

class ProductsRepository {
  final Dio dio;

  ProductsRepository({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get('https://api.escuelajs.co/api/v1/products');
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
