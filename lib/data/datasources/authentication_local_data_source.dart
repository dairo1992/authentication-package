import 'package:authentication/domain/entities/user.dart';

abstract class AuthenticationLocalDataSource {
  Future<User?> getLastLoggedInUser();
  Future<void> cacheUser(User user);
  Future<void> clearCachedUser();
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  // Simulación de almacenamiento local (e.g., SharedPreferences, Hive)
  User? _cachedUser;

  @override
  Future<User?> getLastLoggedInUser() async {
    // Aquí iría la lógica para obtener el usuario de SharedPreferences/Hive
    print('Obteniendo último usuario logueado de la caché local...');
    await Future.delayed(const Duration(milliseconds: 100)); // Simula retardo
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(User user) async {
    // Aquí iría la lógica para guardar el usuario en SharedPreferences/Hive
    print('Guardando usuario en la caché local...');
    _cachedUser = user;
    await Future.delayed(const Duration(milliseconds: 100)); // Simula retardo
  }

  @override
  Future<void> clearCachedUser() async {
    // Aquí iría la lógica para limpiar el usuario de SharedPreferences/Hive
    print('Limpiando caché de usuario local...');
    _cachedUser = null;
    await Future.delayed(const Duration(milliseconds: 100)); // Simula retardo
  }
}