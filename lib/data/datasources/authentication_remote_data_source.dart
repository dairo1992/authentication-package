import 'package:authentication/domain/entities/user.dart';

abstract class AuthenticationRemoteDataSource {
  Future<User> login(String username, String password);
  Future<void> logout();
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  @override
  Future<User> login(String username, String password) async {
    // Simulación de llamada a API para login
    print('Iniciando sesión con $username...');
    await Future.delayed(const Duration(seconds: 2)); // Simula llamada de red
    if (username == 'test' && password == 'password') {
      return User(id: '123', username: username, email: 'test@example.com');
    } else {
      throw Exception('Credenciales inválidas');
    }
  }

  @override
  Future<void> logout() async {
    // Simulación de llamada a API para logout
    print('Cerrando sesión...');
    await Future.delayed(const Duration(seconds: 1)); // Simula llamada de red
  }
}