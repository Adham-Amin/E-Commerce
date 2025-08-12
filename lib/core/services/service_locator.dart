import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_local_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/home/data/repos/home_repo_impl.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repos/home_repo.dart';
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

  
}
