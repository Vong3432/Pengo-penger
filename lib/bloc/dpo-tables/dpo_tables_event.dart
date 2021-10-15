part of 'dpo_tables_bloc.dart';

abstract class DpoTablesEvent extends Equatable {
  const DpoTablesEvent();

  @override
  List<Object> get props => [];
}

class FetchDpoTables extends DpoTablesEvent {}
