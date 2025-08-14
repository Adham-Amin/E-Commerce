import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key, required this.categoryTitle, required this.categoryID});

  final String categoryTitle;
  final String categoryID;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: [
          // category title
          SliverToBoxAdapter(
            child: Text(
              categoryTitle,
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          // the category card
          SliverToBoxAdapter(
            child: CategoryCardItem(categoryTitle,
                ImageAssets.categoryCardImage, goToCategoryProductsListScreen),
          ),
          BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
            builder: (context, state) {
              if (state is SubCategoriesSuccess) {
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.subCategories.length,
                      (context, index) => SubCategoryItem(
                          state.subCategories[index].title,
                          ImageAssets.subcategoryCardImage,
                          categoryID,
                          state.subCategories[index].id,
                          ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: AppSize.s8,
                      crossAxisSpacing: AppSize.s8,
                    ));
              } else if (state is SubCategoriesError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: CustomLoading());
            },
          )
        ],
      ),
    );
  }

  goToCategoryProductsListScreen() {
    // todo implement this function
  }
}
