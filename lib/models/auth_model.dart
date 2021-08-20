class Auth {
  const Auth(
      {required this.username,
      required this.id,
      required this.avatar,
      required this.phone,
      required this.token,
      required this.email,
      this.password});

  factory Auth.fromJson(dynamic json) {
    final dynamic user = json['user'];
    return Auth(
      id: user['id'] as int,
      username: user['username'].toString(),
      avatar: user['avatar'].toString(),
      phone: user['phone'].toString(),
      email: user['email'].toString(),
      token: json['token'].toString(),
    );
  }

  final int id;
  final String username;
  final String email;
  final String phone;
  final String avatar;
  final String? password;
  final String token;
}
