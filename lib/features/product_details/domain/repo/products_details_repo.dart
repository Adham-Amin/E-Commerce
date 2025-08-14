import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRepo {
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      {required String id});
}
