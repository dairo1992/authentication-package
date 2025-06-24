// BLoC de autenticación
import 'package:bloc/bloc.dart';
import 'package:authentication/domain/entities/user.dart';
import 'package:authentication/domain/use_cases/get_current_user.dart';
import 'package:authentication/domain/use_cases/login_user.dart';
import 'package:authentication/domain/use_cases/logout_user.dart';
import 'package:authentication/presentation/bloc/authentication_event.dart';
import 'package:authentication/presentation/bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;

  AuthenticationBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.getCurrentUser,
  }) : super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final user = await getCurrentUser();
      if (user != null) {
        emit(AuthenticationAuthenticated(user));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (e) {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final user = await loginUser(event.username, event.password);
      emit(AuthenticationAuthenticated(user));
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      emit(
        AuthenticationUnauthenticated(),
      ); // Regresa al estado de no autenticado
    }
  }

  Future<void> _onLoggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await logoutUser();
      emit(AuthenticationUnauthenticated());
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      // Si el logout falla, podríamos considerar mantener el estado actual o forzar un deslogueo
      emit(AuthenticationUnauthenticated());
    }
  }
}
