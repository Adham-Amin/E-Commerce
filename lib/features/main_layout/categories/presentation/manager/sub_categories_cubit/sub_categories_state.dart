part of 'sub_categories_cubit.dart';

sealed class SubCategoriesState {}

final class SubCategoriesInitial extends SubCategoriesState {}
final class SubCategoriesLoading extends SubCategoriesState {}
final class SubCategoriesSuccess extends SubCategoriesState {
  final List<SubCategoriesEntity> subCategories;
  SubCategoriesSuccess({required this.subCategories});
}
final class SubCategoriesError extends SubCategoriesState {
  final String message;
  SubCategoriesError({required this.message});
}
