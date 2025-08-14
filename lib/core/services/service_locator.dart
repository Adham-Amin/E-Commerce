import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/repos/categories_repo_impl.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repos/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_local_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/data/repos/home_repo_impl.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/features/product_details/data/data_source/product_details_remote_data_source.dart';
import 'package:ecommerce_app/features/product_details/data/repos/product_details_repo_impl.dart';
import 'package:ecommerce_app/features/product_details/domain/repo/products_details_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> serverLocator() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<AuthCubit>(
    AuthCubit(authRepo: getIt<AuthRepo>()),
  );

  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(),
  );

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      homeRemoteDataSource: getIt<HomeRemoteDataSource>(),
      homeLocalDataSource: getIt<HomeLocalDataSource>(),
    ),
  );

  getIt.registerSingleton<CategoriesRemoteDataSource>(
    CategoriesRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerSingleton<CategoriesRepo>(
    CategoriesRepoImpl(
      categoriesRemoteDataSource: getIt<CategoriesRemoteDataSource>(),
    ),
  );

  getIt.registerSingleton<ProductDetailsRemoteDataSource>(
    ProductDetailsRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerSingleton<ProductDetailsRepo>(
    ProductDetailsRepoImpl(
      productDetailsRemoteDataSource: getIt<ProductDetailsRemoteDataSource>(),
    ),
  );
}
