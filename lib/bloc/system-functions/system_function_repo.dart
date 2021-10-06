import 'package:penger/bloc/system-functions/system_function_api_provider.dart';
import 'package:penger/models/system_function_model.dart';

class SystemFunctionRepo {
  factory SystemFunctionRepo() {
    return _instance;
  }

  SystemFunctionRepo._constructor();

  static final SystemFunctionRepo _instance = SystemFunctionRepo._constructor();
  final SystemFunctionApiProvider _systemFunctionApiProvider =
      SystemFunctionApiProvider();

  Future<List<SystemFunction>> fetchSystemFunctions() async =>
      _systemFunctionApiProvider.fetchSystemFunctions();
}
