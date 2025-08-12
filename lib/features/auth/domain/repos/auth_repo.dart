import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signin_request.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signup_request.dart';
import 'package:ecommerce_app/features/auth/data/models/responses/auth_response/auth_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponse>> signUp(
      {required SignupRequest userData});
  Future<Either<Failure, AuthResponse>> signIn(
      {required SigninRequest userData});
}
