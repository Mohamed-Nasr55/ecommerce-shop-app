import 'package:dio/dio.dart';
import 'package:mysmallshop/core/category/category_model.dart';

class CategoriesRepository {
  final Dio dio;
  CategoriesRepository({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<List<Category>> fetchCategories() async {
    final response = await dio.get('https://api.escuelajs.co/api/v1/categories');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
