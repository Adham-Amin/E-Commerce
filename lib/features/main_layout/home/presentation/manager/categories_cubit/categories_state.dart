part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}
final class CategoriesLoading extends CategoriesState {}
final class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;
  CategoriesSuccess({required this.categories});
}
final class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError({required this.message});
}
