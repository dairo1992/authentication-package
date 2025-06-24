import 'package:authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<User> login(String username, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}