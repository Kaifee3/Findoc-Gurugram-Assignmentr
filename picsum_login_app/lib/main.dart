import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/pics_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/pics/pics_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PicsLoginApp());
}

class PicsLoginApp extends StatelessWidget {
  const PicsLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    final picsRepository = PicsRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => PicsBloc(repository: picsRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Picsum Login App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Montserrat',
        ),
        routes: {
          '/': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}
