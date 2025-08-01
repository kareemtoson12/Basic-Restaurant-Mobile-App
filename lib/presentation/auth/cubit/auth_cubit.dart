// auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/usecaes/auth.dart';

import 'package:task/presentation/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit(this.signUpUseCase, this.loginUseCase) : super(AuthInitial());

  Future<void> signUp(String email, String password, String userName) async {
    emit(AuthLoading());

    try {
      final user = await signUpUseCase(email, password, userName);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  //login

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
