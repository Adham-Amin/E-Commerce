import 'package:ecommerce_app/features/cart/domain/entities/product_cart_entity.dart';

class CartEnitity {
  final int numOfCartItems;
  final int totalCartPrice;
  final List<ProductCartEntity> prdocts;

  CartEnitity({required this.numOfCartItems, required this.totalCartPrice, required this.prdocts});

}