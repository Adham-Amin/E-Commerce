import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/main_layout/home/data/models/categories_response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/home/data/models/products_response/products_response.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<List<ProductsEntity>> getProducts();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;
  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    var response = await apiService.get(endPoint: 'categories');
    var categories = CategoriesResponse.fromJson(response).toEntities();
    Hive.box('categories').addAll(categories);
    return categories;
  }

  @override
  Future<List<ProductsEntity>> getProducts() async {
    var response = await apiService.get(endPoint: 'products');
    var products = ProductsResponse.fromJson(response).toEntities();
    Hive.box('products').addAll(products);
    return products;
  }
}
