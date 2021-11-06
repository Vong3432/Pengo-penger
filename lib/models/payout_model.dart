import 'package:json_annotation/json_annotation.dart';

part 'payout_model.g.dart';

@JsonSerializable()
class Payout {
  const Payout({
    required this.currency,
    required this.currentAmount,
    required this.currentAmountCharge,
    required this.totalCurrentAmount,
    required this.totalGross,
    required this.totalCharge,
    required this.totalEarn,
    required this.roundedTotalEarn,
    required this.roundedAmount,
    required this.chargeRate,
    required this.transactions,
  });

  factory Payout.fromJson(Map<String, dynamic> json) => _$PayoutFromJson(json);
  Map<String, dynamic> toJson() => _$PayoutToJson(this);

  final String currency;

  @JsonKey(name: 'current_amount')
  final String currentAmount;

  @JsonKey(name: 'current_amount_charge')
  final String currentAmountCharge;

  @JsonKey(name: 'total_current_amount')
  final String totalCurrentAmount;

  @JsonKey(name: 'total_gross')
  final String totalGross;

  @JsonKey(name: 'total_charge')
  final String totalCharge;

  @JsonKey(name: 'total_earn')
  final String totalEarn;

  @JsonKey(name: 'rounded_total_earn')
  final String roundedTotalEarn;

  @JsonKey(name: 'rounded_amount')
  final String roundedAmount;

  @JsonKey(name: 'charge_rate')
  final double chargeRate;

  final List<Transaction> transactions;
}

@JsonSerializable()
class Transaction {
  const Transaction({
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.isPaid,
    required this.grossAmount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  final int amount;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'is_paid')
  final bool isPaid;

  @JsonKey(name: 'gross_amount')
  final double grossAmount;
}
