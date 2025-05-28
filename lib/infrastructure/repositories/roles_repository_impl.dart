import '../../domain/entities/role.dart';
import '../../domain/repositories/roles_repository.dart';
import '../data_sources/roles_api_service.dart';

class RolesRepositoryImpl implements RolesRepository {
  final RolesApiService apiService;

  RolesRepositoryImpl(this.apiService);

  @override
  Future<List<Role>> getRoles(String token) {
    return apiService.getRoles(token);
  }
} 