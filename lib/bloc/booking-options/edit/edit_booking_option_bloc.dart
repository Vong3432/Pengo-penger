import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/booking-categories/edit/edit_booking_category_bloc.dart';
import 'package:penger/bloc/booking-items/edit/edit_booking_item_bloc.dart';
import 'package:penger/bloc/booking-options/booking_option_repo.dart';
import 'package:penger/models/response_model.dart';
import 'package:penger/models/system_function_model.dart';

part 'edit_booking_option_event.dart';
part 'edit_booking_option_state.dart';

class EditBookingOptionBloc
    extends Bloc<EditBookingOptionEvent, EditBookingOptionState> {
  EditBookingOptionBloc() : super(BookingOptionUpdateInitial()) {
    on<UpdateBookingOptionEvent>(_updateCategoryFunctions);
  }

  final BookingOptionRepo _repo = BookingOptionRepo();

  void _updateCategoryFunctions(UpdateBookingOptionEvent event,
      Emitter<EditBookingOptionState> emit) async {
    try {
      emit(BookingOptionUpdating());
      final List<int?> ids =
          event.systemFunctions.map((SystemFunction f) => f.id).toList();
      final ResponseModel response =
          await _repo.updateBookingOption(event.categoryId, ids);
      emit(BookingOptionUpdated(response));
    } catch (e) {
      emit(BookingOptionNotUpdated(e));
    }
  }
}
