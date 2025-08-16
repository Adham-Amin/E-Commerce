import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/total_price_and_checkout_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: getMediumStyle(fontSize: 20, color: ColorManager.textColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage(
                IconsAssets.icSearch,
              ),
              color: ColorManager.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage(IconsAssets.icCart),
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartSuccess) {
              return Column(
                children: [
                  Expanded(
                    // the list of cart items ===============
                    child: ListView.separated(
                      itemBuilder: (context, index) => CartItemWidget(
                        imagePath: state.cart?.prdocts[index].image ?? '',
                        title: state.cart?.prdocts[index].title ?? '',
                        price: (state.cart?.prdocts[index].price ?? 0).toInt(),
                        quantity:
                            (state.cart?.prdocts[index].quantity ?? 0).toInt(),
                        onDeleteTap: () {
                          BlocProvider.of<CartCubit>(context)
                              .removeProductFromCart(
                                  productId:
                                      state.cart?.prdocts[index].id ?? '');
                        },
                        onDecrementTap: (value) {
                          BlocProvider.of<CartCubit>(context)
                              .updateProductInCart(
                                  productId:
                                      state.cart?.prdocts[index].id ?? '',
                                  quantity: (--value).toString());
                        },
                        onIncrementTap: (value) {
                          BlocProvider.of<CartCubit>(context)
                              .updateProductInCart(
                                  productId:
                                      state.cart?.prdocts[index].id ?? '',
                                  quantity: (++value).toString());
                        },
                        size: 40,
                        color: Colors.black,
                        colorName: 'Black',
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSize.s12.h),
                      itemCount: state.cart?.prdocts.length ?? 0,
                    ),
                  ),
                  // the total price and checkout button========
                  TotalPriceAndCheckoutBotton(
                    totalPrice: state.cart?.totalCartPrice ?? 0,
                    checkoutButtonOnTap: () {},
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else {
              return const CustomLoading();
            }
          },
        ),
      ),
    );
  }
}
