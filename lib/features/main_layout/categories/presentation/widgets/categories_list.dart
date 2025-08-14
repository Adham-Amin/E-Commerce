import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_item.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key, required this.onTap});

  final Function(String id, String title) onTap;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // Index of the currently selected category
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: ColorManager.containerGray,
        border: Border(
            // set the border for only 3 sides
            top: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withValues(alpha: 0.3)),
            left: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withValues(alpha: 0.3)),
            bottom: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withValues(alpha: 0.3))),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
      ),

      // the categories items list
      child: ClipRRect(
        // clip the corners of the container that hold the list view
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesSuccess) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) => CategoryItem(
                  index,
                  state.categories[index].id,
                  state.categories[index].name,
                  selectedIndex == index,
                  onItemClick,
                ),
              );
            } else if (state is CategoriesError) {
              return Center(child: Text(state.message));
            } else {
              return const CustomLoading();
            }
          },
        ),
      ),
    ));
  }

  // callback function to change the selected index
  onItemClick(int index, {required String id, required String title}) {
    widget.onTap(id, title);
    setState(() {
      selectedIndex = index;
    });
  }
}
