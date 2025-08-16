import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_enitity.dart';

abstract class CartRepo {
  Future<Either<Failure, CartEnitity>> getCart();
  Future<Either<Failure, void>> addProductToCart({required String productId});
  Future<Either<Failure, CartEnitity>> deleteProductFromCart({required String productId});
  Future<Either<Failure, CartEnitity>> updateProductInCart({required String productId, required String quantity});
}