import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.homeRepo}) : super(CategoriesInitial());

  final HomeRepo homeRepo;

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    var result = await homeRepo.getCategories();
    result.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) => emit(CategoriesSuccess(categories: categories)),
    );
  }
}
