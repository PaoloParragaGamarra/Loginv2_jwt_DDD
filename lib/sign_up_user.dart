import 'package:lognt_jwt/sing_up_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sign_Up_User {
  static const String _baseUrl = 'http://192.168.18.4:8080/api/v1/authentication';
  static const String _signUpEndpoint = '/sign-up';

  Future<String?> sign_up_user(sing_up_request request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_signUpEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        return jsonResponse['token'];
      } else {
        throw Exception('Failed to sign up: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during sign up: $e');
      rethrow;
    }
  }
}