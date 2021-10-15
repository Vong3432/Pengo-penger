part of 'dpo_columns_bloc.dart';

abstract class DpoColumnsEvent extends Equatable {
  const DpoColumnsEvent();

  @override
  List<Object> get props => [];
}

class FetchColumns extends DpoColumnsEvent {
  const FetchColumns(this.table);
  final DpoTable table;
}

class ClearColumns extends DpoColumnsEvent {}
