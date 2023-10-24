import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/kitchen_model.dart';
import '../utils/constants.dart';

class KitchenApi {
  final Dio _dio = Dio();
  KitchenApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/kitchen';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createKitchen(KitchenRequest kitchenRequest) async {
    Response response = await _dio.post('', data: kitchenRequest.toJson());
    Logger().i(response.data);
  }
}
