import 'package:ecommerce_app/features/auth/data/models/requests/signin_request.dart';
import 'package:ecommerce_app/features/auth/data/models/requests/signup_request.dart';
import 'package:ecommerce_app/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:ecommerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> signIn({required SigninRequest userData}) async {
    emit(AuthLoading());
    var result = await authRepo.signIn(userData: userData);
    result.fold(
      (failure) => emit(
        AuthError(message: failure.message),
      ),
      (userData) => emit(
        AuthSuccess(user: userData),
      ),
    );
  }

  Future<void> signUp({required SignupRequest userData}) async {
    emit(AuthLoading());
    var result = await authRepo.signUp(userData: userData);
    result.fold(
      (failure) => emit(
        AuthError(message: failure.message),
      ),
      (userData) => emit(
        AuthSuccess(user: userData),
      ),
    );
  }
}
