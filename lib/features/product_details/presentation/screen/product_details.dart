import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/features/product_details/domain/repo/products_details_repo.dart';
import 'package:ecommerce_app/features/product_details/presentation/manager/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_color.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_description.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_label.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_rating.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_size.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        productDetailsRepo: getIt.get<ProductDetailsRepo>(),
      ),
      child: ProductDetailsBody(productId: productId,),
    );
  }
}

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({
    super.key, required this.productId,
  });

  final String productId;
  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {

  @override
  void initState() {
    context.read<ProductDetailsCubit>().getProductDetails(
      productId: widget.productId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: getMediumStyle(color: ColorManager.appBarTitleColor)
              .copyWith(fontSize: 20.sp),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(IconsAssets.icSearch),
                color: ColorManager.primary,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: ColorManager.primary,
              )),
        ],
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductSlider(
                          items: state.product.images
                              .map((image) => ProductItem(imageUrl: image))
                              .toList(),
                          initialIndex: 0),
                      SizedBox(
                        height: 24.h,
                      ),
                      ProductLabel(
                          productName: state.product.title,
                          productPrice: 'EGP ${state.product.price}'),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductRating(
                          productBuyers: state.product.sold.toString(),
                          productRating:
                              '${state.product.rating} (${state.product.quantity})'),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductDescription(
                        productDescription: state.product.description,
                      ),
                      ProductSize(
                        size: const [35, 38, 39, 40],
                        onSelected: () {},
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Color',
                          style: getMediumStyle(
                                  color: ColorManager.appBarTitleColor)
                              .copyWith(fontSize: 18.sp)),
                      ProductColor(color: const [
                        Colors.red,
                        Colors.blueAccent,
                        Colors.green,
                        Colors.yellow,
                      ], onSelected: () {}),
                      SizedBox(
                        height: 48.h,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total price',
                                style: getMediumStyle(
                                        color: ColorManager.primary
                                            .withValues(alpha: .6))
                                    .copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                  'EGP ${state.product.price}',
                                  style: getMediumStyle(
                                          color: ColorManager.appBarTitleColor)
                                      .copyWith(fontSize: 18.sp))
                            ],
                          ),
                          SizedBox(
                            width: 33.w,
                          ),
                          Expanded(
                            child: CustomElevatedButton(
                              label: 'Add to cart',
                              onTap: () {},
                              prefixIcon: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: ColorManager.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          } else {
            return CustomLoading();
          }
        },
      ),
    );
  }
}
