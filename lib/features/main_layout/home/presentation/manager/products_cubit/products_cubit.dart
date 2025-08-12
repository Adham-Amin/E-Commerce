import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.homeRepo}) : super(ProductsInitial());

  final HomeRepo homeRepo;

  Future<void> getProducts() async {
    emit(ProductsLoading());
    var result = await homeRepo.getProducts();
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) => emit(ProductsSuccess(products: products)),
    );
  }
}
