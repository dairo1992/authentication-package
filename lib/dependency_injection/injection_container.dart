import 'package:get_it/get_it.dart';
import 'package:authentication/data/datasources/authentication_local_data_source.dart';
import 'package:authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:authentication/data/repositories/authentication_repository_impl.dart';
import 'package:authentication/domain/repositories/authentication_repository.dart';
import 'package:authentication/domain/use_cases/get_current_user.dart';
import 'package:authentication/domain/use_cases/login_user.dart';
import 'package:authentication/domain/use_cases/logout_user.dart';
import 'package:authentication/presentation/bloc/authentication_bloc.dart';

// Este GetIt es el global (el que viene de main.dart)
Future<void> initAuthenticationModule(GetIt sl) async {
  // BLoC
  sl.registerFactory(
    () => AuthenticationBloc(
      loginUser: sl(),
      logoutUser: sl(),
      getCurrentUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );
}
