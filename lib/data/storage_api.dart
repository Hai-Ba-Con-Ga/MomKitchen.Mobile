import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../model/kitchen_model.dart';
import '../utils/constants.dart';

class StorageApi {
  final Dio _dio = Dio();
  StorageApi() {
    _dio.options.baseUrl = '${AppConstants.localhostAdress}/storage';
    _dio.options.contentType = Headers.multipartFormDataContentType;
    _dio.options.responseType = ResponseType.json;
  }

  Future<String?> createStorage(XFile file) async {
    // return "https://momkitchen.s3.ap-southeast-1.amazonaws.com/cc6a28fd-6d14-4f59-91a3-1a888ce00c15";
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.name),
    });
    Response response = await _dio.post(
      '',
      data: formData,
    );
    if (response.statusCode == 200) {
      Logger().i(response.data['data']['url']);
      return response.data['data']['url'];
    } else {
      print('File upload failed with status code: ${response.statusCode}');
    }
    return null;
  }
}
