import 'package:ecommerce_app/features/product_details/domain/entities/product_details_entity.dart';
import 'package:ecommerce_app/features/product_details/domain/repo/products_details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.productDetailsRepo})
      : super(ProductDetailsInitial());

  final ProductDetailsRepo productDetailsRepo;

  Future<void> getProductDetails({required String productId}) async {
    emit(ProductDetailsLoading());
    final result = await productDetailsRepo.getProductDetails(id: productId);
    result.fold(
        (failure) => emit(ProductDetailsError(message: failure.message)),
        (productDetails) =>
            emit(ProductDetailsSuccess(product: productDetails)));
  }
}
