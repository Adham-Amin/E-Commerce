import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/entity/sub_categories_entity.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

class CategoriesRepoImpl extends CategoriesRepo {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepoImpl({required this.categoriesRemoteDataSource});
  @override
  Future<Either<Failure, List<ProductsEntity>>> getProductsCategory(
      {required String idCategory, required String idSubCategory}) async {
    try {
      var data = await categoriesRemoteDataSource.getProductsCategory(
          idCategory: idCategory, idSubCategory: idSubCategory);
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<SubCategoriesEntity>>> getSubCategories(
      {required String id}) async {
    try {
      var data = await categoriesRemoteDataSource.getSubCategories(id: id);
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
