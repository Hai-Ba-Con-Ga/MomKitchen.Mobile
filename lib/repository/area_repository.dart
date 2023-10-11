import '../data/area_api.dart';
import '../model/area_model.dart';

class AreaRepository {
  final AreaApi _areaApi;
  AreaRepository({required AreaApi areaApi}) : _areaApi = areaApi;
  Future<List<Area>> getAll() {
    return _areaApi.getAll();
  }
}
