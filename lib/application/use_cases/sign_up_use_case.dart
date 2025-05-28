import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<String?> execute(User user, String password) {
    return repository.signUp(user, password);
  }
} 