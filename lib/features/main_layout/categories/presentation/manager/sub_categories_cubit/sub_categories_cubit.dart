import 'package:ecommerce_app/features/main_layout/categories/domain/entity/sub_categories_entity.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit({required this.categoriesRepo})
      : super(SubCategoriesInitial());

  final CategoriesRepo categoriesRepo;

  Future<void> getSubCategories({required String id}) async {
    emit(SubCategoriesLoading());
    var result = await categoriesRepo.getSubCategories(id: id);
    result.fold((l) => emit(SubCategoriesError(message: l.message)),
        (r) => emit(SubCategoriesSuccess(subCategories: r)));
  }
}
