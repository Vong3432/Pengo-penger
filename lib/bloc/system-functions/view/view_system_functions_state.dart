part of 'view_system_functions_bloc.dart';

abstract class ViewSystemFunctionsState extends Equatable {
  const ViewSystemFunctionsState();

  @override
  List<Object> get props => [];
}

class ViewSystemFunctionsInitial extends ViewSystemFunctionsState {}

class ViewSystemFunctionsLoading extends ViewSystemFunctionsState {}

class ViewSystemFunctionsLoaded extends ViewSystemFunctionsState {
  const ViewSystemFunctionsLoaded(this.systemFunctions);
  final List<SystemFunction> systemFunctions;
}

class ViewSystemFunctionsNotLoaded extends ViewSystemFunctionsState {}
