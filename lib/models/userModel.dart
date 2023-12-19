class User {
  final String? username;
  final String email;
  final String? firstName;
  final String? lastName;
  final int id;
  final String token;

  User({
    this.username,
    required this.email,
    this.firstName,
    this.lastName,
    required this.id,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      id: json['id'] as int,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'token': token,
    };
  }
}
