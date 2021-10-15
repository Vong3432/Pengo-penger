import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/dpo-columns/dpo_columns_repo.dart';
import 'package:penger/models/dpo_column_model.dart';
import 'package:penger/models/dpo_table_model.dart';

part 'dpo_columns_event.dart';
part 'dpo_columns_state.dart';

class DpoColumnsBloc extends Bloc<DpoColumnsEvent, DpoColumnsState> {
  DpoColumnsBloc() : super(DpoColumnsState()) {
    on<FetchColumns>(_loadColumns);
    on<ClearColumns>(_clearColumns);
  }

  final DpoColumnsRepo _repo = DpoColumnsRepo();

  void _clearColumns(
    ClearColumns event,
    Emitter<DpoColumnsState> emit,
  ) {
    emit(
      state.copyWith(
        status: DpoColumnsStatus.initial,
        dpoColumns: const <DpoColumn>[],
      ),
    );
  }

  Future<void> _loadColumns(
    FetchColumns event,
    Emitter<DpoColumnsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: DpoColumnsStatus.loading,
          table: event.table,
        ),
      );
      final List<DpoColumn> columns =
          await _repo.fetchDpoColumns(event.table.id!);
      emit(
        state.copyWith(
          status: DpoColumnsStatus.success,
          dpoColumns: columns,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: DpoColumnsStatus.failure));
    }
  }
}
