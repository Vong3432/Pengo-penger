import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.username,
    required this.avatar,
    required this.id,
    required this.email,
    required this.phone,
    this.age,
    this.password,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final int id;
  final String username;
  final String email;
  final String phone;
  final String? password;
  final String avatar;
  final Role? role;
  final int? age;
}

@JsonSerializable()
class Role {
  const Role({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  final int id;
  final String name;
  @JsonKey(name: 'is_active')
  final bool isActive;
}
