import 'package:find_your_friends/features/database/database_service.dart';
import 'package:find_your_friends/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  //TODO: Add Dependency injection for both authentication and database service
  AuthenticationService authService = AuthenticationService();
  DatabaseService dbService = DatabaseService();

  @override
  Stream<UserModel> getCurrentUser() {
    return authService.retrieveCurrentUser();
  }

  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return authService.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return authService.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }

  @override
  Future<String?> retrieveUserName(UserModel user) {
    return dbService.retrieveUserName(user);
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
  Future<String?> retrieveUserName(UserModel user);
}
