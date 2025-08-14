import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product_details/data/data_source/product_details_remote_data_source.dart';
import 'package:ecommerce_app/features/product_details/domain/entities/product_details_entity.dart';
import 'package:ecommerce_app/features/product_details/domain/repo/products_details_repo.dart';

class ProductDetailsRepoImpl extends ProductDetailsRepo {
  final ProductDetailsRemoteDataSource productDetailsRemoteDataSource;

  ProductDetailsRepoImpl({required this.productDetailsRemoteDataSource});
  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      {required String id}) async {
    try {
      var data = await productDetailsRemoteDataSource.getProductDetails(id: id);
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
