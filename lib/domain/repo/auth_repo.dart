import 'package:task/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signUp(String email, String password, String userName);
  //login
  Future<UserModel> login(String email, String password);
}
