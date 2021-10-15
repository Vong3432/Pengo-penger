part of 'dpo_columns_bloc.dart';

enum DpoColumnsStatus { initial, loading, success, failure }

class DpoColumnsState extends Equatable {
  const DpoColumnsState({
    this.dpoColumns = const <DpoColumn>[],
    this.status = DpoColumnsStatus.initial,
    this.table,
    this.relatedTable,
  });

  DpoColumnsState copyWith({
    List<DpoColumn>? dpoColumns,
    DpoColumnsStatus? status,
    DpoTable? table,
    DpoTable? relatedTable,
  }) {
    return DpoColumnsState(
      dpoColumns: dpoColumns,
      status: status ?? this.status,
      table: table ?? this.table,
      relatedTable: relatedTable ?? this.relatedTable,
    );
  }

  final List<DpoColumn>? dpoColumns;
  final DpoTable? table;
  final DpoTable? relatedTable;
  final DpoColumnsStatus status;

  @override
  List<Object?> get props => [dpoColumns, status, table, relatedTable];
}
