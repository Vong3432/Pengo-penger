import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/dpo_table_model.dart';

class DpoTableApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<DpoTable>> fetchDpoTables() async {
    try {
      final response = await _apiHelper.get('/penger/available-dpo-tables');
      final data = response.data['data'] as List;

      List<DpoTable> dpoTables = List<DpoTable>.from(
          data.map((i) => DpoTable.fromJson(i as Map<String, dynamic>)));

      return dpoTables;
    } on DioError catch (e) {
      debugPrint("err dpotables: ${e.toString()}");
      throw e.response!.data['msg'].toString();
    }
  }
}
