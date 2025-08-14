import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

import 'datum.dart';
import 'metadata.dart';

class ProductsCategoryResponse {
  int? results;
  Metadata? metadata;
  List<Datum>? data;

  ProductsCategoryResponse({this.results, this.metadata, this.data});

  factory ProductsCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ProductsCategoryResponse(
      results: json['results'] as int?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results,
        'metadata': metadata?.toJson(),
        'data': data?.map((e) => e.toJson()).toList(),
      };

  List<ProductsEntity> toEntities() {
    return data?.map((datum) {
          return ProductsEntity(
            id: datum.id ?? '',
            image: datum.imageCover ?? '',
            title: datum.title ?? '',
            price: datum.price ?? 0,
            rating: datum.ratingsAverage ?? 0,
          );
        }).toList() ??
        [];
  }
}
