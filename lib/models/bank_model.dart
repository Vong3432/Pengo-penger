import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/token.dart';
import 'package:penger/models/user_model.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankAccount {
  BankAccount({
    required this.user,
    required this.tokenData,
    this.pengers,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);
  Map<String, dynamic> toJson() => _$BankAccountToJson(this);

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
