import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../../domain/value_objects/credentials.dart';

class AuthApiService {
  static const String _baseUrl = 'http://192.168.18.4:8080/api/v1/authentication';

  Future<String?> signIn(Credentials credentials) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials.toJson()),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['token'];
    }
    return null;
  }

  Future<String?> signUp(User user, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        ...user.toJson(),
        'password': password,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return json['token'];
    }
    return null;
  }
} 