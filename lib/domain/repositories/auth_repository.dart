import '../entities/user.dart';
import '../value_objects/credentials.dart';

abstract class AuthRepository {
  Future<String?> signIn(Credentials credentials);
  Future<String?> signUp(User user, String password);
} 