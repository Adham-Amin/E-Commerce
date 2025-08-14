import 'dart:async';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/core/widget/product_card.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
    context.read<CategoriesCubit>().getCategories();
    context.read<ProductsCubit>().getProducts();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAdsWidget(
            adsImages: adsImages,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          Column(
            children: [
              CustomSectionBar(sectionNname: 'Categories', function: () {}),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesSuccess) {
                    return SizedBox(
                      height: 320.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomCategoryWidget(
                            category: state.categories[index],
                          );
                        },
                        itemCount: state.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 10,
                        ),
                      ),
                    );
                  } else if (state is CategoriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return CustomLoading();
                  }
                },
              ),
              SizedBox(height: 12.h),
              // CustomSectionBar(sectionNname: 'Brands', function: () {}),
              // SizedBox(
              //   height: 270.h,
              //   child: GridView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return const CustomBrandWidget();
              //     },
              //     itemCount: 20,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //     ),
              //   ),
              // ),
              CustomSectionBar(
                sectionNname: 'Most Selling Products',
                function: () {},
              ),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsSuccess) {
                    return SizedBox(
                      height: 340.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productId: state.products[index].id,
                            title: state.products[index].title,
                            description:
                                'This is a short description of the product',
                            rating: state.products[index].rating,
                            price: state.products[index].price,
                            priceBeforeDiscound: 1500,
                            image: state.products[index].image,
                          );
                        },
                        itemCount: 20,
                      ),
                    );
                  } else if (state is ProductsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return CustomLoading();
                  }
                },
              ),
              SizedBox(height: 12.h),
            ],
          )
        ],
      ),
    );
  }
}
