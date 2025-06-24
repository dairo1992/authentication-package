import 'package:authentication/domain/repositories/authentication_repository.dart';
import 'package:authentication/domain/entities/user.dart';
import 'package:authentication/data/datasources/authentication_local_data_source.dart';
import 'package:authentication/data/datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String username, String password) async {
    try {
      final user = await remoteDataSource.login(username, password);
      await localDataSource.cacheUser(user); // Cachea el usuario
      return user;
    } catch (e) {
      print('Error en login del repositorio: $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCachedUser(); // Limpia el caché
    } catch (e) {
      print('Error en logout del repositorio: $e');
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getLastLoggedInUser();
      if (cachedUser != null) {
        return cachedUser;
      }
      // En un escenario real, aquí podrías intentar validar el token o la sesión
      // con el servidor si no hay usuario en caché.
      return null;
    } catch (e) {
      print('Error en getCurrentUser del repositorio: $e');
      return null;
    }
  }
}
