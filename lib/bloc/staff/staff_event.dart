part of 'staff_bloc.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object> get props => [];
}

class FetchStaffList extends StaffEvent {}

class AddStaff extends StaffEvent {
  const AddStaff({
    required this.name,
    required this.password,
    required this.email,
    required this.age,
    required this.phone,
  });

  final String name;
  final String password;
  final String email;
  final int age;
  final String phone;
}

class EditStaff extends StaffEvent {
  const EditStaff({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.age,
    required this.phone,
  });

  final int id;
  final String name;
  final String password;
  final String email;
  final int age;
  final String phone;
}
