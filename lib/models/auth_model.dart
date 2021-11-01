import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/token.dart';
import 'package:penger/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class Auth extends Equatable {
  Auth({
    required this.user,
    required this.tokenData,
    this.pengers,
    this.selectedPenger,
    this.username,
    this.phone,
    this.token,
    this.avatar,
  });

  Auth copyWith({
    List<Penger>? pengers,
    Penger? selectedPenger,
  }) {
    return Auth(
      user: user,
      tokenData: tokenData,
      pengers: pengers ?? this.pengers,
      selectedPenger: selectedPenger ?? this.selectedPenger,
      avatar: avatar,
      phone: phone,
      username: username,
      token: token,
    );
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    final Auth t = _$AuthFromJson(json);
    if (t.pengers != null) {
      // ignore: prefer_conditional_assignment
      if (t.selectedPenger == null && t.pengers?.isNotEmpty == true) {
        t.selectedPenger = t.pengers![0];
      }
    }
    t.token = t.tokenData.token;
    t.phone = t.user.phone;
    t.username = t.user.username;
    t.avatar = t.user.avatar;

    return t;
  }
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  String? phone;

  String? avatar;

  String? username;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'token')
  final Token tokenData;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? token;

  final List<Penger>? pengers;

  Penger? selectedPenger;

  @override
  // TODO: implement props
  List<Object?> get props => [user, tokenData, pengers, selectedPenger];

  // set selectedPenger(Penger? p) => p;
  // Penger? get selectedPenger => _selectedPenger;
}
