import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/role.dart';

class RolesApiService {
  static const String _baseUrl = 'http://192.168.18.4:8080/ap/v1/roles';

  Future<List<Role>> getRoles(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Role.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load roles');
    }
  }
} 