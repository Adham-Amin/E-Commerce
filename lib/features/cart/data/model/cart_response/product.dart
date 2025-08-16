import 'package:ecommerce_app/features/cart/data/model/cart_response/brand.dart';
import 'package:ecommerce_app/features/cart/data/model/cart_response/category.dart';
import 'package:ecommerce_app/features/cart/data/model/cart_response/subcategory.dart';

class Product {
  final List<SubCategory> subcategory;
  final String id;
  final String title;
  final int quantity;
  final String imageCover;
  final Category category;
  final Brand brand;
  final double ratingsAverage;

  Product({
    required this.subcategory,
    required this.id,
    required this.title,
    required this.quantity,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      subcategory: (json['subcategory'] as List<dynamic>? ?? [])
          .map((e) => SubCategory.fromJson(e))
          .toList(),
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      quantity: json['quantity'] ?? 0,
      imageCover: json['imageCover'] ?? '',
      category: Category.fromJson(json['category'] ?? {}),
      brand: Brand.fromJson(json['brand'] ?? {}),
      ratingsAverage:
          (json['ratingsAverage'] != null) ? json['ratingsAverage'].toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory': subcategory.map((e) => e.toJson()).toList(),
      '_id': id,
      'title': title,
      'quantity': quantity,
      'imageCover': imageCover,
      'category': category.toJson(),
      'brand': brand.toJson(),
      'ratingsAverage': ratingsAverage,
    };
  }
}