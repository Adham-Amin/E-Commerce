import 'package:ecommerce_app/features/cart/data/model/cart_response/cart_data.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_enitity.dart';

class CartResponse {
  final String status;
  final int numOfCartItems;
  final String cartId;
  final CartData data;

  CartResponse({
    required this.status,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json['status'] ?? '',
      numOfCartItems: json['numOfCartItems'] ?? 0,
      cartId: json['cartId'] ?? '',
      data: CartData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'numOfCartItems': numOfCartItems,
      'cartId': cartId,
      'data': data.toJson(),
    };
  }

  CartEnitity toEntity() {
    return CartEnitity(
        totalCartPrice: data.totalCartPrice,
        numOfCartItems: numOfCartItems,
        prdocts: data.toEntity());
  }
}
