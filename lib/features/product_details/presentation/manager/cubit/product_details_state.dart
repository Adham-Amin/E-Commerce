part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class ProductDetailsLoading extends ProductDetailsState {}
final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity product;
  ProductDetailsSuccess({required this.product});
}
final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}
