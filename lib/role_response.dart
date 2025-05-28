class role_response {
  int id;
  String name;

  role_response({
    required this.id,
    required this.name,
  });

  factory role_response.fromJson(Map<String, dynamic> json) {
    try {
      return role_response(
        id: json['id'] as int,
        name: json['name'] as String,
      );
    } catch (e) {
      print('Error parsing role response: $e');
      print('JSON data: $json');
      rethrow;
    }
  }
}