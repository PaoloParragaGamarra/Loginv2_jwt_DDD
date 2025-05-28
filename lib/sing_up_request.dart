class sing_up_request {
  String username;
  String password;
  String role;

  sing_up_request({
    required this.username,
    required this.password,
    required this.role,
  });

  Map <String, dynamic> toJson()=>{
    'username': username,
    'password': password,
    'roles': [role],
  };

}