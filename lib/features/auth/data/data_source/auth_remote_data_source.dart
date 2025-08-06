import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signin_request.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signup_request.dart';
import 'package:ecommerce_app/features/auth/data/models/responses/auth_response/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUp({required SignupRequest userData});
  Future<AuthResponse> signIn({required SigninRequest userData});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final ApiService apiService;
  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AuthResponse> signIn({required SigninRequest userData}) async {
    var response = await apiService.post(
      endPoint: 'auth/signin',
      data: userData.toJson(),
    );
    return AuthResponse.fromJson(response);
  }

  @override
  Future<AuthResponse> signUp({required SignupRequest userData}) async {
    var response = await apiService.post(
      endPoint: 'auth/signup',
      data: userData.toJson(),
    );
    return AuthResponse.fromJson(response);
  }
}
