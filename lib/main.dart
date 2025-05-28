import 'package:flutter/material.dart';
import 'presentation/screens/sign_in_screen.dart';
import 'presentation/screens/sign_up_screen.dart';
import 'presentation/screens/roles_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DDD Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (_) => const SignInScreen(),
        '/sign-up': (_) => const SignUpScreen(),
        '/roles': (_) => const RolesScreen(),
      },
    );
  }
}
