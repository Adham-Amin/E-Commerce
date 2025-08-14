part of 'products_category_cubit.dart';

sealed class ProductsCategoryState {}

final class ProductsCategoryInitial extends ProductsCategoryState {}
final class ProductsCategoryLoading extends ProductsCategoryState {}
final class ProductsCategorySuccess extends ProductsCategoryState {
  final List<ProductsEntity> products;
  ProductsCategorySuccess({required this.products});
}
final class ProductsCategoryError extends ProductsCategoryState {
  final String message;

  ProductsCategoryError({required this.message});
}
