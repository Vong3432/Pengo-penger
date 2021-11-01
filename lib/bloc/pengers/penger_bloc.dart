import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/response_model.dart';

part 'penger_event.dart';
part 'penger_state.dart';

class PengerBloc extends Bloc<PengerEvent, PengerState> {
  PengerBloc() : super(PengerInitial());

  final PengerRepo _pengerRepo = PengerRepo();

  @override
  Stream<PengerState> mapEventToState(
    PengerEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchPengers) {
      yield* _mapFetchPengersToState();
    }
    if (event is FetchPenger) {
      yield* _mapFetchPengerToState(event.id);
    }
    if (event is CreatePenger) {
      yield* _mapCreatePengerToState(event);
    }
    if (event is UpdatePenger) {
      yield* _mapUpdatePengerToState(event);
    }
  }

  Stream<PengerState> _mapCreatePengerToState(CreatePenger event) async* {
    try {
      yield PengerAdding();
      final ResponseModel response = await _pengerRepo.createPenger(
        event.name,
        event.poster,
        event.locationName,
        event.lat,
        event.lng,
        event.description,
      );
      yield PengerAdded(response);
    } catch (e) {
      yield PengerNotAdded(e);
    }
  }

  Stream<PengerState> _mapUpdatePengerToState(UpdatePenger event) async* {
    try {
      yield PengerUpdating();
      final ResponseModel response = await _pengerRepo.updatePenger(
        event.id,
        event.name,
        event.poster,
        event.locationName,
        event.lat,
        event.lng,
        event.description,
      );
      yield PengerUpdated(response);
    } catch (e) {
      yield PengerNotUpdated(e);
    }
  }

  Stream<PengerState> _mapFetchPengersToState() async* {
    try {
      yield PengersLoading();
      final List<Penger> pengers = await _pengerRepo.fetchPengers();
      yield PengersLoaded(pengers);
    } catch (_) {
      yield PengersNotLoaded();
    }
  }

  Stream<PengerState> _mapFetchPengerToState(int id) async* {
    try {
      yield PengerLoading();
      final Penger penger = await _pengerRepo.fetchPenger(id);
      yield PengerLoaded(penger);
    } catch (_) {
      yield PengerNotLoaded();
    }
  }
}
