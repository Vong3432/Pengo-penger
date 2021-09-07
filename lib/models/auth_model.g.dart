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
  );
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.tokenData,
      'pengers': instance.pengers,
    };
