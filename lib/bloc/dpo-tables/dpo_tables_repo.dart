import 'package:penger/bloc/dpo-tables/dpo_tables_api_provider.dart';
import 'package:penger/models/dpo_table_model.dart';

class DpoTableRepo {
  factory DpoTableRepo() {
    return _instance;
  }

  DpoTableRepo._constructor();

  static final DpoTableRepo _instance = DpoTableRepo._constructor();
  final DpoTableApiProvider _dpoTableApiProvider = DpoTableApiProvider();

  Future<List<DpoTable>> fetchDpoTables() async =>
      _dpoTableApiProvider.fetchDpoTables();
}
