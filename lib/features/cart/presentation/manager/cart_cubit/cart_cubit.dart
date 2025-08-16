import 'package:ecommerce_app/features/cart/domain/entities/cart_enitity.dart';
import 'package:ecommerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepo}) : super(CartInitial());

  final CartRepo cartRepo;

  bool isProductInCart(String productId) {
    if (state is CartSuccess) {
      final currentCart = (state as CartSuccess).cart;
      return currentCart?.prdocts.any((product) => product.id == productId) ??
          false;
    }
    return false;
  }

  Future<void> getCart() async {
    emit(CartLoading());
    final cart = await cartRepo.getCart();
    cart.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartSuccess(cart: cart)),
    );
  }

  Future<void> updateProductInCart(
      {required String productId, required String quantity}) async {
    emit(CartLoading());
    final cart = await cartRepo.updateProductInCart(
        productId: productId, quantity: quantity);
    cart.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartSuccess(cart: cart)),
    );
  }

  Future<void> addProductToCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.addProductToCart(productId: productId);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (_) async {
        await getCart();
      },
    );
  }

  Future<void> removeProductFromCart({required String productId}) async {
    emit(CartLoading());
    final cart = await cartRepo.deleteProductFromCart(productId: productId);
    cart.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartSuccess(cart: cart)),
    );
  }
}
