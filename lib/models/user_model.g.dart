// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    avatar: json['avatar'] as String,
    id: json['id'] as int,
    email: json['email'] as String,
    phone: json['phone'] as String,
    age: json['age'] as int?,
    password: json['password'] as String?,
    role: json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'avatar': instance.avatar,
      'role': instance.role,
      'age': instance.age,
    };

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    id: json['id'] as int,
    name: json['name'] as String,
    isActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_active': instance.isActive,
    };
