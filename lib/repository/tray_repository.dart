import '../data/tray_api.dart';
import '../model/tray_model.dart';

class TrayRepository {
  final TrayApi _trayApi;
  TrayRepository({required TrayApi trayApi}) : _trayApi = trayApi;
  Future<void> createTray(TrayCreateRequest tray) {
    return _trayApi.createTray(tray);
  }

  Future<List<Tray>> getAllTrayes() {
    return _trayApi.getAllTrayes();
  }

  Future<Tray> getTrayById(String trayId) {
    return _trayApi.getTrayById(trayId);
  }

  Future<void> updateTray(String trayId, Tray trayRequest) {
    return _trayApi.updateTray(trayId, trayRequest);
  }

  Future<void> deleteTray(String trayId) {
    return _trayApi.deleteTray(trayId);
  }
}
