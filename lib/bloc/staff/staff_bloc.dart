import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/staff/staff_repo.dart';
import 'package:penger/models/response_model.dart';
import 'package:penger/models/user_model.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffListInitial()) {
    on<FetchStaffList>(_fetchStaffList);
    on<AddStaff>(_addStaff);
    on<EditStaff>(_editStaff);
  }

  final StaffRepo _repo = StaffRepo();

  Future<void> _fetchStaffList(
    FetchStaffList event,
    Emitter<StaffState> emit,
  ) async {
    try {
      emit(StaffListLoading());
      final List<User> staffList = await _repo.fetchStaffList();
      emit(StaffListLoaded(staffList));
    } catch (e) {
      emit(StaffListNotLoaded());
    }
  }

  Future<void> _addStaff(
    AddStaff event,
    Emitter<StaffState> emit,
  ) async {
    try {
      emit(StaffAdding());
      final ResponseModel response = await _repo.createStaff(
        event.name,
        event.password,
        event.email,
        event.age,
        event.phone,
      );
      emit(StaffAdded(response));
    } catch (e) {
      emit(StaffNotAdded(e));
    }
  }

  Future<void> _editStaff(
    EditStaff event,
    Emitter<StaffState> emit,
  ) async {
    try {
      emit(StaffUpdating());
      final ResponseModel response = await _repo.updateStaff(
        event.id,
        event.name,
        event.password,
        event.email,
        event.age,
        event.phone,
      );
      emit(StaffUpdated(response));
    } catch (e) {
      emit(StaffNotUpdated(e));
    }
  }
}
