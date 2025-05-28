import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../infrastructure/data_sources/auth_api_service.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../application/use_cases/sign_up_use_case.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController txtName;
  late TextEditingController txtPassword;
  String? selectedRole;
  late SignUpUseCase signUpUseCase;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtPassword = TextEditingController();
    final repo = AuthRepositoryImpl(AuthApiService());
    signUpUseCase = SignUpUseCase(repo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownButtonFormField<String>(
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: 'ROLE_ADMIN', child: Text('ADMIN')),
                  DropdownMenuItem(value: 'ROLE_PROVIDER', child: Text('PROVIDER')),
                  DropdownMenuItem(value: 'ROLE_RESIDENT', child: Text('RESIDENT')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Role',
                  hintText: 'Select your role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedRole == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a role')),
                  );
                  return;
                }
                final user = User(
                  username: txtName.text,
                  roles: [selectedRole!],
                );
                final token = await signUpUseCase.execute(user, txtPassword.text);

                if (token != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('jwt_token', token);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User created successfully!')),
                    );
                    Navigator.pushReplacementNamed(context, '/roles');
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to create user')),
                    );
                  }
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/sign-in');
              },
              child: const Text('Already have an account? Sign In'),
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