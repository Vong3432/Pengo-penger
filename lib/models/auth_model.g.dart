// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    tokenData: Token.fromJson(json['token'] as Map<String, dynamic>),
    pengers: (json['pengers'] as List<dynamic>?)
        ?.map((e) => Penger.fromJson(e as Map<String, dynamic>))
        .toList(),
    selectedPenger: json['selectedPenger'] == null
        ? null
        : Penger.fromJson(json['selectedPenger'] as Map<String, dynamic>),
    username: json['username'] as String?,
    phone: json['phone'] as String?,
    avatar: json['avatar'] as String?,
  )..email = json['email'] as String?;
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
      'username': instance.username,
      'user': instance.user,
      'token': instance.tokenData,
      'pengers': instance.pengers,
      'selectedPenger': instance.selectedPenger,
    };
