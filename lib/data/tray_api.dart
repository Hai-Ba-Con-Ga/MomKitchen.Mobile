import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/tray_model.dart';
import '../utils/constants.dart';

class TrayApi {
  final Dio _dio = Dio();
  TrayApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/Tray';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<void> createTray(TrayCreateRequest trayRequest) async {
    try {
      Logger().i(trayRequest.toRawJson());
      Response response = await _dio.post('', data: trayRequest);
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error creating Tray: $error");
      throw error;
    }
  }

  Future<List<Tray>> getAllTrayes() async {
    try {
      // add fields to get
      Response response = await _dio.get('', queryParameters: {'fields': 'UpdatedDate:desc'});
      List<dynamic> TrayData = response.data['data'] as List<dynamic>;
      List<Tray> Trayes = TrayData.map((data) => Tray.fromJson(data)).toList();
      return Trayes;
    } catch (error) {
      Logger().e("Error fetching Trayes: $error");
      throw error;
    }
  }

  Future<void> updateTray(String trayId, Tray trayRequest) async {
    try {
      Response response = await _dio.put('', queryParameters: {'TrayId': trayId}, data: trayRequest.toRawJson());
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error updating Tray: $error");
      throw error;
    }
  }

  Future<void> deleteTray(String trayId) async {
    try {
      Logger().i(trayId);
      Response response = await _dio.delete('', queryParameters: {'TrayId': trayId});
      Logger().i(response.data);
    } catch (error) {
      Logger().e("Error deleting Tray: $error");
      throw error;
    }
  }

  Future<Tray> getTrayById(String trayId) async {
    try {
      Response response = await _dio.get('', queryParameters: {'TrayId': trayId});
      Map<String, dynamic> trayData = response.data as Map<String, dynamic>;
      Tray tray = Tray.fromJson(trayData);
      return tray;
    } catch (error) {
      Logger().e("Error fetching Tray by ID: $error");
      throw error;
    }
  }
}
