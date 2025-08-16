import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final String title;
  final int price;
  final String description;
  final double priceBeforeDiscound;
  final double rating;
  final String productId;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.priceBeforeDiscound,
    required this.description,
    required this.productId,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 4) {
      return title;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.productDetails,
          arguments: widget.productId),
      child: SizedBox(
        width: 200.w,
        height: 280.h,
        child: Container(
          width: 280,
          margin: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: ColorManager.primary.withValues(alpha: 0.8),
            ),
          ),
          child: Column(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(24),
              //       topRight: Radius.circular(24),
              //     ),
              //     child: AspectRatio(
              //       aspectRatio: 16 / 9,
              //       child: CachedNetworkImage(
              //         imageUrl: product.imageCover ?? "",
              //         fit: BoxFit.fill,
              //         placeholder: (context, url) =>
              //             const Center(child: CircularProgressIndicator()),
              //         errorWidget: (context, url, error) =>
              //             const Center(child: Icon(Icons.error)),
              //       ),
              //     ),
              //   ),
              // ),

              Expanded(
                flex: 1,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26.r),
                          topRight: Radius.circular(26.r),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.01,
                      right: width * 0.02,
                      child: Container(
                        height: height * 0.036,
                        width: width * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            IconsAssets.icWithList,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truncateTitle(widget.title),
                        maxLines: 2,
                        style: getMediumStyle(
                          color: ColorManager.primary,
                          fontSize: 16.sp,
                        ),
                      ),
                      Expanded(child: SizedBox(height: 8.h)),
                      // Text(
                      //   truncateTitle(description),
                      //   style: getRegularStyle(
                      //     color: ColorManager.primary,
                      //     fontSize: 14.sp,
                      //   ),
                      // ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "EGP ${widget.price}",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getRegularStyle(
                              color: ColorManager.primary,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            "${widget.priceBeforeDiscound} EGP ",
                            style: getTextWithLine(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Reviews",
                                style: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "${widget.rating}",
                                style: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          BlocProvider.of<CartCubit>(context)
                                  .isProductInCart(widget.productId)
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      BlocProvider.of<CartCubit>(context)
                                        .removeProductFromCart(productId: widget.productId);
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_circle_rounded,
                                    color: ColorManager.primary,
                                    size: 36,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      BlocProvider.of<CartCubit>(context)
                                        .addProductToCart(productId: widget.productId);
                                    });
                                  },
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: ColorManager.primary,
                                    size: 36,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
