part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductsEntity> products;
  ProductsSuccess({required this.products});
}

final class ProductsError extends ProductsState {
  final String message;
  ProductsError({required this.message});
}
