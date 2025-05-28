import '../../domain/entities/role.dart';
import '../../domain/repositories/roles_repository.dart';

class GetRolesUseCase {
  final RolesRepository repository;

  GetRolesUseCase(this.repository);

  Future<List<Role>> execute(String token) {
    return repository.getRoles(token);
  }
} 