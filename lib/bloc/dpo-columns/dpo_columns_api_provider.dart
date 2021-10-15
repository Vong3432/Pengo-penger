import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/dpo_column_model.dart';
import 'package:penger/models/dpo_table_model.dart';

class DpoColumnApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<DpoColumn>> fetchDpoColumns(int tableId) async {
    try {
      final response = await _apiHelper.get('/penger/dpo-tables/$tableId');
      final data = response.data['data'];

      final DpoTable dpoTable = DpoTable.fromJson(data as Map<String, dynamic>);

      List<DpoColumn> dpoColumns = dpoTable.dpoColumns ?? [];

      return dpoColumns;
    } on DioError catch (e) {
      debugPrint("err DpoColumns: ${e.toString()}");
      throw e.response!.data['msg'].toString();
    }
  }
}
