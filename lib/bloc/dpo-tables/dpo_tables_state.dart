part of 'dpo_tables_bloc.dart';

enum DpoTablesStatus { initial, loading, success, failure }

class DpoTablesState extends Equatable {
  const DpoTablesState({
    this.dpoTables = const <DpoTable>[],
    this.status = DpoTablesStatus.initial,
  });

  DpoTablesState copyWith({
    List<DpoTable>? dpoTables,
    DpoTablesStatus? status,
  }) {
    return DpoTablesState(
      dpoTables: dpoTables ?? this.dpoTables,
      status: status ?? this.status,
    );
  }

  final List<DpoTable> dpoTables;
  final DpoTablesStatus status;

  @override
  List<Object> get props => [dpoTables, status];
}
