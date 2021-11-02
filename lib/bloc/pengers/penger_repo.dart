import 'package:image_picker/image_picker.dart';
import 'package:penger/bloc/pengers/penger_api_provider.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/response_model.dart';

class PengerRepo {
  factory PengerRepo() {
    return _instance;
  }

  PengerRepo._constructor();

  static final PengerRepo _instance = PengerRepo._constructor();
  final PengerApiProvider _pengerApiProvider = PengerApiProvider();

  Future<List<Penger>> fetchPengers() async =>
      _pengerApiProvider.fetchPengers();

  Future<ResponseModel> createPenger(
    String name,
    XFile poster,
    String locationName,
    double lat,
    double lng,
    String? description,
  ) async =>
      _pengerApiProvider.createPenger(
        name,
        poster,
        locationName,
        lat,
        lng,
        description,
      );

  Future<ResponseModel> updatePenger(
    int id,
    String name,
    XFile? poster,
    String locationName,
    double lat,
    double lng,
    String? description,
  ) async =>
      _pengerApiProvider.updatePenger(
        id,
        name,
        poster,
        locationName,
        lat,
        lng,
        description,
      );

  Future<Penger> fetchPenger(int id) async =>
      _pengerApiProvider.fetchPenger(id);

  Future<int> fetchTotalStaffStat() async =>
      _pengerApiProvider.fetchTotalStaff();
}
