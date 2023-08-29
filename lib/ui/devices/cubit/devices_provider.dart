import 'package:plantpulse/ui/devices/model/get_device_data_response.dart';
import 'package:plantpulse/ui/devices/repository/devices_repository.dart';
import 'package:flutter/material.dart';

import '../model/save_device_response.dart';

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    loadDevices();
  }
  final DevicesRepository _repository = DevicesRepository();

  bool _loadingDevices = false;
  bool get loadingDevices => _loadingDevices;
  set loadingDevices(bool value) {
    _loadingDevices = value;
    notifyListeners();
  }

  List<Records>? _devicesData;
  List<Records>? get devicesData => _devicesData;
  set devicesData(List<Records>? value) {
    _devicesData = value;
    notifyListeners();
  }

  List<Records>? _devicesDataDetails;
  List<Records>? get devicesDataDetails => _devicesDataDetails;
  set devicesDataDetails(List<Records>? value) {
    _devicesDataDetails = value;
    notifyListeners();
  }

  void loadDevices() async {
    loadingDevices = true;
    try {
      final data = await _repository.getUserDevices();
      if (data.isNotEmpty) {
        devicesData = data;
      } else {
        throw Exception();
      }
    } catch (_) {
      devicesData = devicesData;
    } finally {
      loadingDevices = false;
    }
  }
  void loadFullDevicesData(hostname) async {
     loadingDevices = true;
     try {
       final fullDeviceData = await _repository.getFullDeviceData(hostname);
       if (fullDeviceData.data!.isNotEmpty) {
         devicesDataDetails = fullDeviceData.data;
       } else {
         throw Exception();
       }
     } catch (_) {
       devicesDataDetails = _devicesDataDetails;
     } finally {
       loadingDevices = false;
     }
   }

  Future<SaveDeviceResponse> addNewDevice(espDevice) async {
    final result = await _repository.saveDevice(espDevice.name);
    loadDevices();
    return result;
  }
}
