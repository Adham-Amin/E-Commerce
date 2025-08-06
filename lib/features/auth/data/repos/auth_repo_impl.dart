import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signin_request.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signup_request.dart';
import 'package:ecommerce_app/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:ecommerce_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, AuthResponse>> signIn(
      {required SigninRequest userData}) async {
    try {
      var data = await authRemoteDataSource.signIn(userData: userData);
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp(
      {required SignupRequest userData}) async {
    try {
      var data = await authRemoteDataSource.signUp(userData: userData);
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
