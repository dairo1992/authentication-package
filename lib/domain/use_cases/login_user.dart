// Caso de uso: Iniciar sesión de usuario
import 'package:authentication/domain/entities/user.dart';
import 'package:authentication/domain/repositories/authentication_repository.dart';

class LoginUser {
  final AuthenticationRepository repository;

  LoginUser(this.repository);

  Future<User> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
