import 'package:flutter/material.dart';
import 'package:lognt_jwt/Roles.dart';
import 'package:lognt_jwt/sign_in_request.dart';
import 'package:lognt_jwt/sign_in_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController txtName;
  late TextEditingController txtPassword;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
      body: Center(
          child: Column(
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
              const SizedBox(
                height: 10,
              ),
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Roles()));
                  },
                  child: Text("Roles")
              ),
              ElevatedButton(
                /*
                  onPressed: () {
                    Sign_Up_User().sign_up_user(
                        sing_up_request(
                            username: txtName.text,
                            password: txtPassword.text,
                            role: txtRole.text
                        )
                    );
                    print('Username: ${txtName.text}, Password: ${txtPassword.text}, Role: ${txtRole.text}');
                  },
                  child:  Text('Register')
                  */
                  onPressed: () async {
                    final result = await sign_in_user().login(
                        sign_in_request(
                            username: txtName.text,
                            password: txtPassword.text
                        )
                    );

                    if (result != null) {
                      // Store the token in SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('jwt_token', result.token);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful!'))
                      );

                      // Navigate to Roles screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Roles()),
                      );
                    } else {
                      // Show error message to user
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed. Please check your credentials.'))
                      );
                    }
                  },
                  child: const Text('Login')
              )
            ],
          )
      ),
    );
  }
}
