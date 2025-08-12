import 'package:hive_flutter/hive_flutter.dart';
part 'category_entity.g.dart';
@HiveType(typeId: 0)
class CategoryEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String image;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
  });
}
