// Molecule: Formulario de Login
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/presentation/bloc/authentication_bloc.dart';
import 'package:authentication/presentation/bloc/authentication_event.dart';
import 'package:authentication/presentation/bloc/authentication_state.dart';
import 'package:authentication/presentation/atoms/custom_text_field.dart';
import 'package:authentication/presentation/atoms/primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      LoggedIn(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final bool isLoading = state is AuthenticationLoading;
        return Column(
          children: [
            CustomTextField(
              controller: _usernameController,
              labelText: 'Usuario',
              hintText: 'Ingrese su nombre de usuario',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Contraseña',
              hintText: 'Ingrese su contraseña',
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Iniciar Sesión',
              onPressed: _onLoginButtonPressed,
              isLoading: isLoading,
            ),
          ],
        );
      },
    );
  }
}
