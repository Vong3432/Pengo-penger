import 'package:dio/dio.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/response_model.dart';

class BookingOptionApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseModel> updateBookingOption(
      int categoryId, List<int?> ids) async {
    try {
      final response = await _apiHelper.put(
        '/penger/booking-options/$categoryId',
        data: {
          "system_function_ids": ids,
        },
        isFormData: false,
      );

      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw Exception((e as DioError).error);
    }
  }
}
