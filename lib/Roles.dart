import 'package:flutter/material.dart';
import 'package:lognt_jwt/role_service.dart';
import 'package:lognt_jwt/Sign_In.dart';

class Roles extends StatefulWidget {
  const Roles({super.key});

  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: role_service.getRoles(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            String errorMessage = 'An error occurred';
            if (snapshot.error.toString().contains('Unauthorized')) {
              errorMessage = 'Your session has expired. Please sign in again.';
            } else if (snapshot.error.toString().contains('No authentication token')) {
              errorMessage = 'Please sign in to view roles';
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: const Text('Go to Sign In'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No roles found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var role = snapshot.data![index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Id: ${role.id}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: Colors.black26,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Name: ${role.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.orangeAccent,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: Colors.black26,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}