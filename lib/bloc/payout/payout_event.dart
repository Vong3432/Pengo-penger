part of 'payout_bloc.dart';

abstract class PayoutEvent extends Equatable {
  const PayoutEvent();

  @override
  List<Object> get props => [];
}

class FetchPayoutInfo extends PayoutEvent {}
