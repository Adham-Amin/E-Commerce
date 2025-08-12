import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeLocalDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<List<ProductsEntity>> getProducts();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<CategoryEntity>> getCategories() async {
    var box = await Hive.openBox<CategoryEntity>('categories');
    return box.values.toList();
  }

  @override
  Future<List<ProductsEntity>> getProducts() async {
    var box = await Hive.openBox<ProductsEntity>('products');
    return box.values.toList();
  }
}