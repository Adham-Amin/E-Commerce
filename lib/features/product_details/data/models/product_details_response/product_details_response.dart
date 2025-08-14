import 'package:ecommerce_app/features/product_details/domain/entities/product_details_entity.dart';

import 'data.dart';

class ProductDetailsResponse {
  Data? data;

  ProductDetailsResponse({this.data});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };

  ProductDetailsEntity toEntity() => ProductDetailsEntity(
        id: data?.id ?? '',
        sold: data?.sold ?? 0,
        title: data?.title ?? '',
        rating: data?.ratingsAverage ?? 0,
        images: data?.images ?? [],
        description: data?.description ?? '',
        quantity: data?.quantity ?? 0,
        price: data?.price ?? 0,
      );
}
