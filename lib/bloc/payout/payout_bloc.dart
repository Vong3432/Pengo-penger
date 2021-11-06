import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/models/payout_model.dart';

part 'payout_event.dart';
part 'payout_state.dart';

class PayoutBloc extends Bloc<PayoutEvent, PayoutState> {
  PayoutBloc() : super(PayoutInitial()) {
    on<FetchPayoutInfo>(_fetchPayoutInfo);
  }

  final PengerRepo _repo = PengerRepo();

  Future<void> _fetchPayoutInfo(
      FetchPayoutInfo event, Emitter<PayoutState> emit) async {
    try {
      emit(PayoutLoading());
      final Payout payout = await _repo.fetchPayoutInfo();
      emit(PayoutLoaded(payout));
    } catch (e) {
      emit(PayoutLoadedFailed());
    }
  }
}
