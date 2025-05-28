import 'package:lognt_jwt/sign_in_request.dart';
import 'package:lognt_jwt/sign_in_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class sign_in_user{
  static const String _baseUrl = 'http://192.168.18.4:8080/api/v1/authentication';
  static const String _signIpEndpoint = '/sign-in';
  Future<sign_in_response?>login (sign_in_request request) async{
    final response = await http.post(
      Uri.parse('$_baseUrl$_signIpEndpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return sign_in_response.fromJson(json);
    } else {
      print("Login fallido: ${response.body}");
      return null;
    }
  }
}