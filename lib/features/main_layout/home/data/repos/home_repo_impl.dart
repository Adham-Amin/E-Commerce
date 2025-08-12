import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/functions/check_network.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_local_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    bool isConnected = await ckeckNetwork();
    if (isConnected) {
      try {
        var categories = await homeRemoteDataSource.getCategories();
        return Right(categories);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDioException(e));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      try {
        var categories = await homeLocalDataSource.getCategories();
        return Right(categories);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts() async {
    bool isConnected = await ckeckNetwork();
    if (isConnected) {
      try {
        var products = await homeRemoteDataSource.getProducts();
        return Right(products);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDioException(e));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      try {
        var products = await homeLocalDataSource.getProducts();
        return Right(products);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
