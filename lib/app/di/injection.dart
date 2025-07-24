// app/di/injector.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/data/data%20source/setUp.dart';
import 'package:task/data/repo/auth_impl.dart';
import 'package:task/domain/usecaes/auth.dart';
import 'package:task/presentation/auth/cubit/auth_cubit.dart';

class Injector {
  static AuthCubit provideAuthCubit() {
    final firebaseAuth = FirebaseAuth.instance;
    final remoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
    );
    final repo = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
    final useCase = SignUpUseCase(repo);
    return AuthCubit(useCase);
  }
}
