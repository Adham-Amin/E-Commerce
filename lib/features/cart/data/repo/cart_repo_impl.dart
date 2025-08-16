import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_enitity.dart';
import 'package:ecommerce_app/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final CartRemoteDataSource remoteDataSource;
  CartRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addProductToCart(
      {required String productId}) async {
    try {
      var data = await remoteDataSource.addProductToCart(productId: productId);
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
  Future<Either<Failure, CartEnitity>> deleteProductFromCart(
      {required String productId}) async {
    try {
      var data =
          await remoteDataSource.deleteProductFromCart(productId: productId);
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
  Future<Either<Failure, CartEnitity>> getCart() async {
    try {
      var data = await remoteDataSource.getCart();
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
  Future<Either<Failure, CartEnitity>> updateProductInCart(
      {required String productId, required String quantity}) async {
    try {
      var data = await remoteDataSource.updateProductInCart(
          productId: productId, quantity: quantity);
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
