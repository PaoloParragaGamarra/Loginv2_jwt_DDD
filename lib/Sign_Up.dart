import 'package:flutter/material.dart';
import 'package:lognt_jwt/Sign_In.dart';
import 'package:lognt_jwt/sign_up_user.dart';
import 'package:lognt_jwt/sing_up_request.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}
class _Sign_UpState extends State<Sign_Up> {
  late TextEditingController txtName;
  late TextEditingController txtPassword;
  late TextEditingController txtRole;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtPassword = TextEditingController();
    txtRole = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButtonFormField<String>(
                  value: null,
                  items: const [
                    DropdownMenuItem(value: 'ROLE_ADMIN', child: Text('ADMIN')),
                    DropdownMenuItem(value: 'ROLE_PROVIDER', child: Text('PROVIDER')),
                    DropdownMenuItem(value: 'ROLE_RESIDENT', child: Text('RESIDENT')),
                  ],
                  onChanged: (value) {
                    txtRole.text = value ?? '';
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
                  onPressed: () async {  // Make this async
                    final result = await Sign_Up_User().sign_up_user(
                        sing_up_request(
                            username: txtName.text,
                            password: txtPassword.text,
                            role: txtRole.text
                        )
                    );

                    if (result != null) {
                      print('User created successfully!');
                      print('Username: ${txtName.text}');
                      print('Roles: ${txtRole.text}');

                      //show a success message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User created successfully!'))
                      );

                      // Navigate to login or home screen
                    } else {
                      // Show error message to user
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to create user'))
                      );
                    }
                  },
                  child: const Text('Register')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
                  },
                  child: Text("Sign In")
              )
            ],
          )
      ),
    );
  }
}