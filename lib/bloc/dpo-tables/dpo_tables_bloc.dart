import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/dpo-tables/dpo_tables_repo.dart';
import 'package:penger/models/dpo_table_model.dart';

part 'dpo_tables_event.dart';
part 'dpo_tables_state.dart';

class DpoTablesBloc extends Bloc<DpoTablesEvent, DpoTablesState> {
  DpoTablesBloc() : super(DpoTablesState()) {
    on<FetchDpoTables>(_loadDpoTables);
  }

  final DpoTableRepo _repo = DpoTableRepo();

  _loadDpoTables(
    FetchDpoTables event,
    Emitter<DpoTablesState> emit,
  ) async {
    try {
      emit(state.copyWith(
        dpoTables: [],
        status: DpoTablesStatus.loading,
      ));
      final List<DpoTable> dpoTables = await _repo.fetchDpoTables();
      emit(state.copyWith(
        dpoTables: dpoTables,
        status: DpoTablesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: DpoTablesStatus.failure));
    }
  }
}
