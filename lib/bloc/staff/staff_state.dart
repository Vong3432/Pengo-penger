part of 'staff_bloc.dart';

abstract class StaffState extends Equatable {
  const StaffState();

  @override
  List<Object> get props => [];
}

class StaffListInitial extends StaffState {}

class StaffListLoading extends StaffState {}

class StaffListLoaded extends StaffState {
  const StaffListLoaded(this.staffList);
  final List<User> staffList;
}

class StaffListNotLoaded extends StaffState {}

class StaffAddInitial extends StaffState {}

class StaffAdding extends StaffState {}

class StaffAdded extends StaffState {
  const StaffAdded(this.response);

  final ResponseModel response;
}

class StaffNotAdded extends StaffState {
  const StaffNotAdded(this.e);

  final Object? e;
}

class StaffUpdateInitial extends StaffState {}

class StaffUpdating extends StaffState {}

class StaffUpdated extends StaffState {
  const StaffUpdated(this.response);

  final ResponseModel response;
}

class StaffNotUpdated extends StaffState {
  const StaffNotUpdated(this.e);

  final Object? e;
}
