import 'package:ecommerce_app/features/cart/data/model/cart_response/product.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product_cart_entity.dart';

class CartProduct {
  final int count;
  final String id;
  final Product product;
  final num price;

  CartProduct({
    required this.count,
    required this.id,
    required this.product,
    required this.price,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      count: json['count'] ?? 0,
      id: json['_id'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      '_id': id,
      'product': product.toJson(),
      'price': price,
    };
  }

  ProductCartEntity toEntity() => ProductCartEntity(
        image: product.imageCover,
        id: product.id,
        quantity: count,
        title: product.title,
        price: price,
      );
}
