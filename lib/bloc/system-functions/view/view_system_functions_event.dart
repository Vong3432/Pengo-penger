part of 'view_system_functions_bloc.dart';

abstract class ViewSystemFunctionsEvent extends Equatable {
  const ViewSystemFunctionsEvent();

  @override
  List<Object> get props => [];
}

class FetchSystemFunctionsEvent extends ViewSystemFunctionsEvent {}
