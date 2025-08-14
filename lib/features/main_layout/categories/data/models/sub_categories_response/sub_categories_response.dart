import 'package:ecommerce_app/features/main_layout/categories/domain/entity/sub_categories_entity.dart';

import 'datum.dart';
import 'metadata.dart';

class SubCategoriesResponse {
  int? results;
  Metadata? metadata;
  List<Datum>? data;

  SubCategoriesResponse({this.results, this.metadata, this.data});

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoriesResponse(
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

  List<SubCategoriesEntity> toEntities() {
    return data?.map((datum) {
          return SubCategoriesEntity(
            id: datum.id ?? '',
            title: datum.name ?? '',
          );
        }).toList() ??
        [];
  }
}
