// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payout _$PayoutFromJson(Map<String, dynamic> json) {
  return Payout(
    currency: json['currency'] as String,
    currentAmount: json['current_amount'] as String,
    currentAmountCharge: json['current_amount_charge'] as String,
    totalCurrentAmount: json['total_current_amount'] as String,
    totalGross: json['total_gross'] as String,
    totalCharge: json['total_charge'] as String,
    totalEarn: json['total_earn'] as String,
    roundedTotalEarn: json['rounded_total_earn'] as String,
    roundedAmount: json['rounded_amount'] as String,
    chargeRate: (json['charge_rate'] as num).toDouble(),
    transactions: (json['transactions'] as List<dynamic>)
        .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PayoutToJson(Payout instance) => <String, dynamic>{
      'currency': instance.currency,
      'current_amount': instance.currentAmount,
      'current_amount_charge': instance.currentAmountCharge,
      'total_current_amount': instance.totalCurrentAmount,
      'total_gross': instance.totalGross,
      'total_charge': instance.totalCharge,
      'total_earn': instance.totalEarn,
      'rounded_total_earn': instance.roundedTotalEarn,
      'rounded_amount': instance.roundedAmount,
      'charge_rate': instance.chargeRate,
      'transactions': instance.transactions,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    amount: json['amount'] as int,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
    isPaid: json['is_paid'] as bool,
    grossAmount: (json['gross_amount'] as num).toDouble(),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_paid': instance.isPaid,
      'gross_amount': instance.grossAmount,
    };
