import 'package:dio/dio.dart';

import '../model/area_model.dart';
import '../utils/constants.dart';

class AreaApi {
  final Dio _dio = Dio();
  AreaApi() {
    _dio.options.baseUrl = '${AppConstants.domainAddress}/Area';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }
  Future<List<Area>> getAll() async {
    Response response = await _dio.get('');
    return (response.data['data'] as List)
        .map((e) => Area.fromJson(e))
        .toList();
  }
}
