import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/booking-close-dates/booking_close_date_repo.dart';
import 'package:penger/models/booking_close_date_model.dart';
import 'package:penger/models/response_model.dart';

part 'booking_close_date_event.dart';
part 'booking_close_date_state.dart';

class BookingCloseDateBloc
    extends Bloc<BookingCloseDateEvent, BookingCloseDateState> {
  BookingCloseDateBloc() : super(BookingCloseDateListInitial()) {
    on<FetchCloseDates>(_fetchCloseDates);
    on<AddCloseDate>(_addCloseDate);
    on<UpdateCloseDate>(_editCloseDate);
    on<DeleteCloseDate>(_deleteCloseDate);
  }

  final BookingCloseDateRepo _repo = BookingCloseDateRepo();

  Future<void> _fetchCloseDates(
    FetchCloseDates event,
    Emitter<BookingCloseDateState> emit,
  ) async {
    try {
      emit(BookingCloseDateListLoading());
      final List<BookingCloseDate> list = await _repo.fetchCloseDates();
      emit(BookingCloseDateListLoaded(list));
    } catch (e) {
      debugPrint("$e");
      emit(BookingCloseDateListNotLoaded());
    }
  }

  Future<void> _addCloseDate(
    AddCloseDate event,
    Emitter<BookingCloseDateState> emit,
  ) async {
    try {
      emit(BookingCloseDateAdding());
      final ResponseModel response = await _repo.createCloseDate(
        name: event.name,
        from: event.from,
        to: event.to,
        keyId: event.keyId,
        type: event.type,
      );
      emit(BookingCloseDateAdded(response));
    } catch (e) {
      emit(BookingCloseDateNotAdded(e));
    }
  }

  Future<void> _editCloseDate(
    UpdateCloseDate event,
    Emitter<BookingCloseDateState> emit,
  ) async {
    try {
      emit(BookingCloseDateUpdating());
      final ResponseModel response = await _repo.updateCloseDate(
        id: event.id,
        name: event.name,
        from: event.from,
        to: event.to,
        keyId: event.keyId,
        type: event.type,
      );
      emit(BookingCloseDateUpdated(response));
    } catch (e) {
      emit(BookingCloseDateNotUpdated(e));
    }
  }

  Future<void> _deleteCloseDate(
    DeleteCloseDate event,
    Emitter<BookingCloseDateState> emit,
  ) async {
    try {
      await _repo.delCloseDate(event.id);
    } catch (e) {
      debugPrint("delete closedate err: $e");
    }
  }
}
