import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/products_category_cubit/products_category_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sub_categories_list.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  String selectedCategory = 'Music';
  String selectedCategoryId = '';

  @override
  void initState() {
    context
        .read<SubCategoriesCubit>()
        .getSubCategories(id: '6439d61c0049ad0b52b90051');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p12),
      child: Row(
        children: [
          CategoriesList(
            onTap: (id, title) {
              setState(() {
                selectedCategory = title;
                selectedCategoryId = id;
              });
              context.read<SubCategoriesCubit>().getSubCategories(id: id);
            },
          ),
          SizedBox(
            width: AppSize.s16,
          ),
          BlocProvider(
            create: (context) => ProductsCategoryCubit(
              categoriesRepo: getIt.get<CategoriesRepo>(),
            ),
            child: SubCategoriesList(
              categoryTitle: selectedCategory,
              categoryID: selectedCategoryId,
            ),
          )
        ],
      ),
    );
  }
}
