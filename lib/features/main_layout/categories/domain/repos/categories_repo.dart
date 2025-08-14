import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/entity/sub_categories_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<SubCategoriesEntity>>> getSubCategories({required String id});
  Future<Either<Failure, List<ProductsEntity>>> getProductsCategory({required String idCategory, required String idSubCategory});
}