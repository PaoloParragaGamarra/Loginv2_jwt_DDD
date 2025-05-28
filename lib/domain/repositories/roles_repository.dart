import '../entities/role.dart';

abstract class RolesRepository {
  Future<List<Role>> getRoles(String token);
} 