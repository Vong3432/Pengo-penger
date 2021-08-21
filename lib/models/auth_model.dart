import 'package:penger/models/penger_model.dart';

class Auth {
  const Auth({
    required this.username,
    required this.id,
    required this.avatar,
    required this.phone,
    required this.token,
    required this.email,
    this.password,
    this.pengers,
    this.selectedPenger,
  });

  factory Auth.fromJson(dynamic json) {
    final dynamic user = json['user'];
    List<Penger> pengers =
        (json['pengers'] as List).map((i) => Penger.fromJson(i)).toList();

    return Auth(
      id: user['id'] as int,
      username: user['username'].toString(),
      avatar: user['avatar'].toString(),
      phone: user['phone'].toString(),
      email: user['email'].toString(),
      token: json['token']['token'].toString(),
      pengers: pengers,
      selectedPenger: pengers[0],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["username"] = username;
    map["avatar"] = avatar;
    map["phone"] = phone;
    map["email"] = email;
    map["token"] = token;
    map["pengers"] = pengers?.map((Penger e) => e.toMap()).toList();
    map["selected_penger"] = selectedPenger?.toMap();
    // Add all other fields
    return map;
  }

  final int id;
  final String username;
  final String email;
  final String phone;
  final String avatar;
  final String? password;
  final String token;
  final List<Penger>? pengers;
  final Penger? selectedPenger;
}
