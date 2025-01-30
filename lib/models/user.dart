class APIUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  String? password;
  String avatar;

  APIUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    this.password = '123456',
  });

  factory APIUser.fromJson(Map<String, dynamic> json) {
    return APIUser(
      id: json['id'].toString(),
      firstName: json['first_name'] ?? json['firstName'],
      lastName: json['last_name'] ?? json['lastName'],
      email: json['email'],
      avatar: json['avatar'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
}
