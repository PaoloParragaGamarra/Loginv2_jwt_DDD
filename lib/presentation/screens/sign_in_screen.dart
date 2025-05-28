import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/value_objects/credentials.dart';
import '../../infrastructure/data_sources/auth_api_service.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../application/use_cases/sign_in_use_case.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController txtName;
  late TextEditingController txtPassword;
  late SignInUseCase signInUseCase;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtPassword = TextEditingController();
    final repo = AuthRepositoryImpl(AuthApiService());
    signInUseCase = SignInUseCase(repo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: txtName,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: txtPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final credentials = Credentials(
                  username: txtName.text,
                  password: txtPassword.text,
                );
                final token = await signInUseCase.execute(credentials);

                if (token != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('jwt_token', token);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );
                    Navigator.pushReplacementNamed(context, '/roles');
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed. Please check your credentials.')),
                    );
                  }
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/sign-up');
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    txtName.dispose();
    txtPassword.dispose();
    super.dispose();
  }
} 