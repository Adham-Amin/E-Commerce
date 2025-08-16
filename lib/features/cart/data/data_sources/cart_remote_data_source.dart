import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/cart/data/model/cart_response/cart_response.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_enitity.dart';

abstract class CartRemoteDataSource {
  Future<CartEnitity> getCart();
  Future<void> addProductToCart({required String productId});
  Future<CartEnitity> deleteProductFromCart({required String productId});
  Future<CartEnitity> updateProductInCart(
      {required String productId, required String quantity});
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final ApiService apiService;
  CartRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> addProductToCart({required String productId}) async {
    await apiService.post(endPoint: 'cart', data: {'productId': productId});
  }

  @override
  Future<CartEnitity> deleteProductFromCart({required String productId}) async {
    var response = await apiService.delete(endPoint: 'cart/$productId');
    return CartResponse.fromJson(response).toEntity();
  }

  @override
  Future<CartEnitity> getCart() async {
    var response = await apiService.get(endPoint: 'cart');
    return CartResponse.fromJson(response).toEntity();
  }

  @override
  Future<CartEnitity> updateProductInCart(
      {required String productId, required String quantity}) async {
    var response = await apiService.put(
      endPoint: 'cart/$productId',
      data: {'count': quantity},
    );
    return CartResponse.fromJson(response).toEntity();
  }
}
