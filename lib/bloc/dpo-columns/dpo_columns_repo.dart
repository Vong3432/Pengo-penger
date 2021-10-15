import 'package:penger/bloc/dpo-columns/dpo_columns_api_provider.dart';
import 'package:penger/models/dpo_column_model.dart';

class DpoColumnsRepo {
  factory DpoColumnsRepo() {
    return _instance;
  }

  DpoColumnsRepo._constructor();

  static final DpoColumnsRepo _instance = DpoColumnsRepo._constructor();
  final DpoColumnApiProvider _dpoColumnsApiProvider = DpoColumnApiProvider();

  Future<List<DpoColumn>> fetchDpoColumns(int tableId) async =>
      _dpoColumnsApiProvider.fetchDpoColumns(tableId);
}
