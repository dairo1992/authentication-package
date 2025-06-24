import 'package:authentication/domain/repositories/authentication_repository.dart';

class LogoutUser {
  final AuthenticationRepository repository;

  LogoutUser(this.repository);

  Future<void> call() async {
    await repository.logout();
  }
}