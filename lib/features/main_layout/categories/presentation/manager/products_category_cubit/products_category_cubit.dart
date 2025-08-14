import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_category_state.dart';

class ProductsCategoryCubit extends Cubit<ProductsCategoryState> {
  ProductsCategoryCubit({required this.categoriesRepo})
      : super(ProductsCategoryInitial());

  final CategoriesRepo categoriesRepo;

  Future<void> getProductsCategory(
      {required String idCategory, required String idSubCategory}) async {
    emit(ProductsCategoryLoading());
    var result = await categoriesRepo.getProductsCategory(
        idCategory: idCategory, idSubCategory: idSubCategory);
    result.fold((l) => emit(ProductsCategoryError(message: l.message)),
        (r) => emit(ProductsCategorySuccess(products: r)));
  }
}
