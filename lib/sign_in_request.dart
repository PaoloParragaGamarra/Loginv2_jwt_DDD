class sign_in_request {
  String username;
  String password;

  sign_in_request({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    return {
      'username': username,
      'password': password,
    };
  }

}