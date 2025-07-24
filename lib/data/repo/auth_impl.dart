import 'package:task/data/data%20source/remote_ds.dart';
import 'package:task/domain/models/user_model.dart';
import 'package:task/domain/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  //signup
  Future<UserModel> signUp(String email, String password, String userName) {
    return remoteDataSource.signUp(email, password, userName);
  }

  //login
  Future<UserModel> login(String email, String password) {
    {
      return remoteDataSource.login(email, password);
    }
  }
}
