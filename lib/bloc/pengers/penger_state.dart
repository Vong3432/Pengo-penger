part of 'penger_bloc.dart';

abstract class PengerState extends Equatable {
  const PengerState();

  @override
  List<Object> get props => [];
}

class PengersInitial extends PengerState {}

class PengersLoading extends PengerState {}

class PengersLoaded extends PengerState {
  const PengersLoaded(this.pengers);
  final List<Penger> pengers;
}

class PengersNotLoaded extends PengerState {}

class NearestPopularPengersInitial extends PengerState {}

class NearestPopularPengersLoading extends PengerState {}

class NearestPopularPengersLoaded extends PengerState {
  const NearestPopularPengersLoaded(this.nearestPengers, this.poppularPengers);
  final List<Penger> nearestPengers;
  final List<Penger> poppularPengers;
}

class NearestPopularPengersNotLoaded extends PengerState {}

class PengerInitial extends PengerState {}

class PengerLoading extends PengerState {}

class PengerLoaded extends PengerState {
  const PengerLoaded(this.penger);
  final Penger penger;
}

class PengerNotLoaded extends PengerState {}

class PengerAdding extends PengerState {}

class PengerAdded extends PengerState {
  const PengerAdded(this.response);
  final ResponseModel response;
}

class PengerNotAdded extends PengerState {
  const PengerNotAdded(this.e);

  final Object? e;
}

class PengerUpdating extends PengerState {}

class PengerUpdated extends PengerState {
  const PengerUpdated(this.response);
  final ResponseModel response;
}

class PengerNotUpdated extends PengerState {
  const PengerNotUpdated(this.e);

  final Object? e;
}
