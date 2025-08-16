import 'package:ecommerce_app/features/cart/data/model/cart_response/product_cart.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product_cart_entity.dart';

class CartData {
  final String id;
  final String cartOwner;
  final List<CartProduct> products;
  final String createdAt;
  final String updatedAt;
  final int v;
  final int totalCartPrice;

  CartData({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalCartPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['_id'] ?? '',
      cartOwner: json['cartOwner'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => CartProduct.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      totalCartPrice: json['totalCartPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cartOwner': cartOwner,
      'products': products.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'totalCartPrice': totalCartPrice,
    };
  }

  List<ProductCartEntity> toEntity() {
    return products.map((e) => e.toEntity()).toList();
  }
}