// Página de Login (Organismo/Template con ResponsiveLayout)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication/presentation/bloc/authentication_bloc.dart';
import 'package:authentication/presentation/bloc/authentication_event.dart';
import 'package:authentication/presentation/bloc/authentication_state.dart';
import 'package:authentication/presentation/molecules/login_form.dart';
import 'package:authentication/presentation/layouts/responsive_layout.dart'; // Importa el layout responsivo

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetIt.instance<AuthenticationBloc>()
                ..add(AppStarted()), // Inicia el BLoC
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            context.go('/home');
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: const ResponsiveLayout(
          mobileScaffold: _MobileLoginView(),
          webScaffold: _WebLoginView(),
          // tabletScaffold: _TabletLoginView(), // Descomentar si se necesita una vista de tablet específica
        ),
      ),
    );
  }
}

// Vista para dispositivos móviles
class _MobileLoginView extends StatelessWidget {
  const _MobileLoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión (Móvil)')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              const LoginForm(),
              const SizedBox(height: 20),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Vista para dispositivos web/grandes
class _WebLoginView extends StatelessWidget {
  const _WebLoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión (Web)')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ), // Limita el ancho del formulario en web
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajusta la columna a su contenido
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 50),
              const LoginForm(),
              const SizedBox(height: 30),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
