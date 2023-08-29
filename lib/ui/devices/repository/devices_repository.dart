import 'dart:convert';

import 'package:plantpulse/ui/devices/model/save_user_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/get_device_data_response.dart';
import '../model/get_user_devices_response.dart';
import '../model/images_response.dart';
import '../model/save_device_response.dart';
String hostName='';
class DevicesRepository {
  String base = "https://athome.rodlandfarms.com";
  String baseUrl = "https://athome.rodlandfarms.com/api";

  Future<SaveUserResponse> saveUser(String loginToken,  displayName,  email) async {
    final response =
    await http.post(Uri.parse("$base/user/save"), body: {"login_token": loginToken, "name": displayName, "email": email});


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      debugPrint('LOG : ${response.body}');
      final data = SaveUserResponse.fromJson(jsonDecode(response.body));
      FlutterSecureStorage().write(key: 'api_token', value: data.apiToken);
      return data;
    } else {
      //debugPrint('i am here');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return SaveUserResponse(
        success: false,
        apiToken: response.body,
      );
    }
  }

  Future<List<Records>> getUserDevices() async {
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');

    final response = await http.get(Uri.parse("$baseUrl/user/devices?api_token=$apiToken"));

    if (response.statusCode == 200) {
      final foo = jsonDecode(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final devices = GetUserDeviceResponse.fromJson(jsonDecode(response.body)).devices!;
      final List<Records> devicesData = [];
      for (var device in devices) {
        if (device.hostname != null && device.hostname!.isNotEmpty) {
          hostName=device.hostname!;
          final deviceData = await getLatestDeviceData(device.hostname!);
          devicesData.add(deviceData.data!.first);
        }
      }
      return devicesData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return [];
    }
  }

  Future<SaveDeviceResponse> deleteDevice(String hostname) async {
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');
    final response =
        await http.get(Uri.parse("$baseUrl/user/delete/$hostname?api_token=${apiToken!}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SaveDeviceResponse.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return SaveDeviceResponse(
        success: false,
        message: 'Something went wrong',
      );
    }
  }

  Future<GetDeviceDataResponse> getLatestDeviceData(String hostname) async {
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');
    final response =
        await http.get(Uri.parse("$baseUrl/user/$hostname/latest?api_token=${apiToken!}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return GetDeviceDataResponse.fromJson(jsonDecode(response.body), hostname);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return GetDeviceDataResponse(
        success: false,
        data: [],
      );
    }
  }

  Future<GetDeviceDataResponse> getFullDeviceData(String hostname) async {
    // await Future.delayed(Duration(seconds: 100));
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');
    final response =
        await http.get(Uri.parse("$baseUrl/user/devices/$hostname/data?api_token=${apiToken!}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return GetDeviceDataResponse.fromJson(jsonDecode(response.body), hostname);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return GetDeviceDataResponse(
        success: false,
        data: [],
      );
    }
  }

  Future<ImagesResponse> getAllImages(String hostname) async {
    // await Future.delayed(Duration(seconds: 100));
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');
    final response =
        await http.get(Uri.parse("$baseUrl/user/$hostname/images?api_token=${apiToken!}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ImagesResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return ImagesResponse(
        success: false,
        data: [],
      );
    }
  }

  Future<SaveDeviceResponse> saveDevice(String hostname) async {
    String? apiToken = await const FlutterSecureStorage().read(key: 'api_token');
    final response =
        await http.post(Uri.parse("$baseUrl/user/save/$hostname?api_token=${apiToken!}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SaveDeviceResponse.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return SaveDeviceResponse(
        success: false,
        message: "could not save device",
      );
    }
  }
}
