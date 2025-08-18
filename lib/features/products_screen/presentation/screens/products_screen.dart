import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/products_category_cubit/products_category_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen(
      {super.key, required this.idCategory, required this.idSubCategory});

  final String idCategory;
  final String idSubCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCategoryCubit(categoriesRepo: getIt.get<CategoriesRepo>()),
      child: ProductScreenView(
          idCategory: idCategory, idSubCategory: idSubCategory),
    );
  }
}

class ProductScreenView extends StatefulWidget {
  const ProductScreenView({
    super.key,
    required this.idCategory,
    required this.idSubCategory,
  });

  final String idCategory;
  final String idSubCategory;

  @override
  State<ProductScreenView> createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  @override
  void initState() {
    context.read<ProductsCategoryCubit>().getProductsCategory(
        idCategory: widget.idCategory, idSubCategory: widget.idSubCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: const HomeScreenAppBar(
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Expanded(
                child:
                    BlocBuilder<ProductsCategoryCubit, ProductsCategoryState>(
                  builder: (context, state) {
                    if (state is ProductsCategorySuccess) {
                      return GridView.builder(
                        itemCount: state.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return CustomProductWidget(
                            product: state.products[index],
                            image: state.products[index].image,
                            title: state.products[index].title,
                            price: state.products[index].price.toDouble(),
                            rating: state.products[index].rating,
                            discountPercentage: 10,
                            height: height,
                            width: width,
                            description:
                                "Nike is a multinational corporation that designs, develops, and sells athletic footwear ,apparel, and accessories",
                          );
                        },
                        scrollDirection: Axis.vertical,
                      );
                    } else if (state is ProductsCategoryError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
