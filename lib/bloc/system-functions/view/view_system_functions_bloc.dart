import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/system-functions/system_function_repo.dart';
import 'package:penger/models/system_function_model.dart';

part 'view_system_functions_event.dart';
part 'view_system_functions_state.dart';

class ViewSystemFunctionsBloc
    extends Bloc<ViewSystemFunctionsEvent, ViewSystemFunctionsState> {
  ViewSystemFunctionsBloc() : super(ViewSystemFunctionsInitial()) {
    on<FetchSystemFunctionsEvent>(_loadSystemFunctions);
  }

  final SystemFunctionRepo _repo = SystemFunctionRepo();

  void _loadSystemFunctions(
    FetchSystemFunctionsEvent event,
    Emitter<ViewSystemFunctionsState> emit,
  ) async {
    try {
      emit(ViewSystemFunctionsLoading());
      final List<SystemFunction> systemFunctions =
          await _repo.fetchSystemFunctions();
      emit(ViewSystemFunctionsLoaded(systemFunctions));
    } catch (_) {
      emit(ViewSystemFunctionsNotLoaded());
    }
  }
}
