import 'package:penger/bloc/staff/staff_api_provider.dart';
import 'package:penger/models/response_model.dart';
import 'package:penger/models/user_model.dart';

class StaffRepo {
  factory StaffRepo() {
    return _instance;
  }

  StaffRepo._constructor();

  static final StaffRepo _instance = StaffRepo._constructor();
  final StaffApiProvider _staffApiProvider = StaffApiProvider();

  Future<List<User>> fetchStaffList() async =>
      _staffApiProvider.fetchStaffList();

  Future<ResponseModel> createStaff(
    String name,
    String password,
    String email,
    int age,
    String phone,
  ) async =>
      _staffApiProvider.createStaff(
        name,
        password,
        email,
        age,
        phone,
      );

  Future<ResponseModel> updateStaff(
    int id,
    String name,
    String password,
    String email,
    int age,
    String phone,
  ) async =>
      _staffApiProvider.updateStaff(
        id,
        name,
        password,
        email,
        age,
        phone,
      );

  Future<void> delStaff(int id) async => _staffApiProvider.delStaff(id);
}
