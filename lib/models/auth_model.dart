import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/token.dart';
import 'package:penger/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class Auth {
  Auth({
    required this.user,
    required this.tokenData,
    this.pengers,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    final Auth t = _$AuthFromJson(json);
    if (t.pengers != null) {
      t.selectedPenger = t.pengers![0];
    }
    t.token = t.tokenData.token;
    t.phone = t.user.phone;
    t.username = t.user.username;
    t.avatar = t.user.avatar;

    return t;
  }
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String phone;

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String avatar;

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String username;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'token')
  final Token tokenData;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? token;

  final List<Penger>? pengers;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  Penger? selectedPenger;

  // set selectedPenger(Penger? p) => p;
  // Penger? get selectedPenger => _selectedPenger;
}
