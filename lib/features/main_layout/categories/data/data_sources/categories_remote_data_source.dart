import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/models/products_category_response/products_category_response.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/models/sub_categories_response/sub_categories_response.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/entity/sub_categories_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<SubCategoriesEntity>> getSubCategories({required String id});
  Future<List<ProductsEntity>> getProductsCategory(
      {required String idCategory, required String idSubCategory});
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiService apiService;
  CategoriesRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ProductsEntity>> getProductsCategory(
      {required String idCategory, required String idSubCategory}) async {
    var response = await apiService.get(
        endPoint:
            'products?category[in]=$idCategory&subcategory[in]=$idSubCategory');
    return ProductsCategoryResponse.fromJson(response).toEntities();
  }

  @override
  Future<List<SubCategoriesEntity>> getSubCategories(
      {required String id}) async {
    var response = await apiService.get(endPoint: 'categories/$id/subcategories');
    return SubCategoriesResponse.fromJson(response).toEntities();
  }
}
