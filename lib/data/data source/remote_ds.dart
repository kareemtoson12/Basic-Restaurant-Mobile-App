import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/domain/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp(String email, String password, String userName);
  //login
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> signUp(
    String email,
    String password,
    String userName,
  ) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(result.user!, userName);
  }

  //login with firebase

  @override
  Future<UserModel> login(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel.fromFirebaseUser(
      result.user!,
      result.user!.displayName ?? '',
    );
  }
}
