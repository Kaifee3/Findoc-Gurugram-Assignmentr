import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.submissionSuccess) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else if (state.errorMessage != null) {
                        final snack = SnackBar(content: Text(state.errorMessage!));
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration('Email', 'you@example.com').copyWith(
                                errorText: state.isEmailValid || state.email.isEmpty
                                    ? null
                                    : 'Invalid email',
                              ),
                              onChanged: (v) =>
                                  context.read<AuthBloc>().add(AuthEmailChanged(v)),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: _inputDecoration('Password', 'Minimum 8 characters')
                                  .copyWith(
                                errorText: state.isPasswordValid ||
                                        state.password.isEmpty
                                    ? null
                                    : 'Password does not meet requirements',
                              ),
                              onChanged: (v) =>
                                  context.read<AuthBloc>().add(AuthPasswordChanged(v)),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: state.isEmailValid &&
                                        state.isPasswordValid &&
                                        !state.submissionInProgress
                                    ? () => context
                                        .read<AuthBloc>()
                                        .add(AuthSubmitted())
                                    : null,
                                child: state.submissionInProgress
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Submit'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Password must be at least 8 characters and contain uppercase, lowercase, number and symbol.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
