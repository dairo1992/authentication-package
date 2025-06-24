// Caso de uso: Obtener el usuario actual
import 'package:authentication/domain/entities/user.dart';
import 'package:authentication/domain/repositories/authentication_repository.dart';

class GetCurrentUser {
  final AuthenticationRepository repository;

  GetCurrentUser(this.repository);

  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
