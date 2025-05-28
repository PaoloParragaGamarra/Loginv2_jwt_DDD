import 'package:lognt_jwt/role_response.dart';

class list_role{
  static List<role_response>listRole(List<dynamic>listjson){
    List<role_response> list_Role = [];
    for(var item in listjson) {
      final u = role_response.fromJson(item);
      list_Role.add(u);
    }
    return list_Role;
  }
}