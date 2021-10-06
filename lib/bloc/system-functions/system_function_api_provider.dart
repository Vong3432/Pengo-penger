import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/system_function_model.dart';

class SystemFunctionApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<SystemFunction>> fetchSystemFunctions() async {
    try {
      final response = await _apiHelper.get('/penger/system-functions');
      final data = response.data['data'] as List;

      List<SystemFunction> systemFunctions = List<SystemFunction>.from(
          data.map((i) => SystemFunction.fromJson(i as Map<String, dynamic>)));

      return systemFunctions;
    } catch (e) {
      debugPrint("err cat: ${e.toString()}");
      throw Exception(e);
    }
  }
}
