import 'package:task/data/data%20source/setUp.dart';
import 'package:task/domain/models/user_model.dart';
import 'package:task/domain/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserModel> signUp(String email, String password, String userName) {
    return remoteDataSource.signUp(email, password, userName);
  }
}
