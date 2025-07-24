import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String userName;

  UserModel({required this.uid, required this.email, required this.userName});
  //firebase mapping
  factory UserModel.fromFirebaseUser(User user, String userName) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      userName: userName,
    );
  }
}
