import 'package:shared_preferences/shared_preferences.dart';
class share_preferences{
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }
}