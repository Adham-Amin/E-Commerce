import 'package:hive_flutter/hive_flutter.dart';
part 'products_entity.g.dart';
@HiveType(typeId: 1)
class ProductsEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final double rating;

  ProductsEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
  });
}
