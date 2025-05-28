import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lognt_jwt/list_role.dart';
import 'package:lognt_jwt/role_response.dart';
import 'package:http/http.dart' as http;

class role_service {
  static const String _baseUrl = 'http://192.168.18.4:8080/ap/v1';
  static const String _rolesEndpoint = '/roles';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print('Retrieved token: $token'); // Debug log
    return token;
  }

  static Future<List<role_response>> getRoles() async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found in SharedPreferences'); // Debug log
        throw Exception('No authentication token found');
      }

      final url = '$_baseUrl$_rolesEndpoint';
      print('Making request to: $url'); // Debug log
      print('Using token: $token'); // Debug log

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final List<dynamic> responseJson = json.decode(response.body);
        final all_roles = list_role.listRole(responseJson);
        return all_roles;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        throw Exception('Failed to load roles: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in getRoles: $e'); // Debug log
      rethrow;
    }
  }
}