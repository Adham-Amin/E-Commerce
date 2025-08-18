import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/core/services/shared_preferences_service.dart';
import 'package:ecommerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/data_sources/local_watchlist_data_source.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/repos/watchlist_repo_impl.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/routes_manager/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryEntityAdapter());
  Hive.registerAdapter(ProductsEntityAdapter());
  await Hive.openBox<CategoryEntity>('categories');
  await Hive.openBox<ProductsEntity>('products');
  await Hive.openBox<ProductsEntity>('watchlist');
  serverLocator();
  await SharedPreferencesService.init();

  String? token = await SharedPreferencesService().getToken();
  bool isLogin = token != null;

  runApp(MainApp(
    isLogin: isLogin,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductsCubit(homeRepo: getIt.get<HomeRepo>())..getProducts(),
          ),
          BlocProvider(
            create: (context) =>
                CategoriesCubit(homeRepo: getIt.get<HomeRepo>())
                  ..getCategories(),
          ),
          BlocProvider(
            create: (context) =>
                SubCategoriesCubit(categoriesRepo: getIt.get<CategoriesRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                CartCubit(cartRepo: getIt.get<CartRepo>())..getCart(),
          ),
          BlocProvider(
            create: (context) => WatchlistCubit(
              watchlistRepo: WatchlistRepoImpl(
                localWatchlistDataSource: LocalWatchlistDataSourceImpl(),
              ),
            )..loadWatchlist(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: isLogin ? Routes.mainRoute : Routes.signInRoute,
        ),
      ),
    );
  }
}
