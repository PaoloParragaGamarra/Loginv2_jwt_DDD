class sign_in_response{
  int id;
  String username;
  String token;

  sign_in_response({
    required this.id,
    required this.username,
    required this.token,
  });

  factory sign_in_response.fromJson(Map<String, dynamic> json) {
    return sign_in_response(
      id: json['id'] as int,
      username: json['username'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'token': token,
    };
  }
}