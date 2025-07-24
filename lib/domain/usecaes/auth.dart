import 'package:task/domain/models/user_model.dart';
import 'package:task/domain/repo/auth_repo.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserModel> call(String email, String password, String userName) {
    return repository.signUp(email, password, userName);
  }
}
