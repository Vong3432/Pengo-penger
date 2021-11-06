part of 'payout_bloc.dart';

abstract class PayoutState extends Equatable {
  const PayoutState();

  @override
  List<Object> get props => [];
}

class PayoutInitial extends PayoutState {}

class PayoutLoading extends PayoutState {}

class PayoutLoaded extends PayoutState {
  const PayoutLoaded(this.payout);
  final Payout payout;
}

class PayoutLoadedFailed extends PayoutState {}
