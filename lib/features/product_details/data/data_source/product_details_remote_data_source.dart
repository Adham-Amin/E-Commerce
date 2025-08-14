import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/product_details/data/models/product_details_response/product_details_response.dart';
import 'package:ecommerce_app/features/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsEntity> getProductDetails({required String id});
}

class ProductDetailsRemoteDataSourceImpl
    extends ProductDetailsRemoteDataSource {
  final ApiService apiService;
  ProductDetailsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ProductDetailsEntity> getProductDetails({required String id}) async {
    var response = await apiService.get(endPoint: 'products/$id');
    return ProductDetailsResponse.fromJson(response).toEntity();
  }
}
