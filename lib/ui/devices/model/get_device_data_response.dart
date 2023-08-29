import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GetDeviceDataResponse {
  bool? success;
  List<Records>? data;

  GetDeviceDataResponse({this.success, this.data});

  GetDeviceDataResponse.fromJson(Map<String, dynamic> json, String deviceName) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Records>[];
      json['data'].forEach((v) {
        data!.add(new Records.fromJson(v, deviceName));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int? id;
  int? deviceId;
  String? hostName;
  String? sensor;
  String? location;
  String? deviceName;
  num? temperature;
  num? humidity;
  num? moisture;
  num? vpd;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  String? image;
  num? batt;

  Records({
    this.id,
    this.deviceId,
    this.sensor,
    this.location,
    this.deviceName,
    this.temperature,
    this.humidity,
    this.moisture,
    this.vpd,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.batt,
    this.hostName,
  });

  Records.fromJson(Map<String, dynamic> json, String deviceName) {
    id = json['id'];
    deviceId = json['device_id'];
    sensor = json['sensor'];
    location = json['location'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    moisture = json['moisture'];
    vpd = json['vpd'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    // createdAt =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(json['created_at'], true).toLocal().toString();
    updatedAt = json['updated_at'];
    image = json['image'];
    batt = json['batt'];
    hostName = deviceName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['sensor'] = this.sensor;
    data['location'] = this.location;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['moisture'] = this.moisture;
    data['vpd'] = this.vpd;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['batt'] = this.batt;
    data['hostname'] = this.deviceName;
    return data;
  }

  DateTime getGraphTime() {
    // print(createdAt!);
    // print(DateTime.parse(createdAt!).toIso8601String());

    String isoString = DateTime.parse(createdAt!)
        .toIso8601String(); // say "2020-08-20 01:30:00.000Z" in ISO8601 format.

    // On conversion, changes to "2020-08-20 01:30:00.000"

    String convertedString = isoString.replaceAll(RegExp(r'Z'), '');
    convertedString = convertedString.replaceAll('T', ' ');
    convertedString = convertedString.replaceAll('.000', '');
    // print(convertedString);
    // The converted timestamp string is then parsed to DateTime type and returned

    // toxValueMapper

    DateTime correctTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(convertedString, true).toLocal();

    return correctTime; //returned the CorrectTimestamp
    // return DateTime.parse(createdAt!).hour.toString()+":"+DateTime.parse(createdAt!).minute.toString();
    // return DateTime.parse(createdAt!).month.toString()+"/"+DateTime.parse(createdAt!).day.toString()+"/"+DateTime.parse(createdAt!).year.toString()+"-"+DateTime.parse(createdAt!).hour.toString()+":"+DateTime.parse(createdAt!).minute.toString()+":"+DateTime.parse(createdAt!).second.toString();
    // return DateTime.parse(createdAt!).day.toString() + ", " + DateTime.parse(createdAt!).hour.toString() + ":" + DateTime.parse(createdAt!).minute.toString();
  }
}

class ChartData {
  List<Records>? deviceRecords;

  ChartData({this.deviceRecords});

  List<SplineSeries<Records, DateTime>>? getSpineTempData() {
    return <SplineSeries<Records, DateTime>>[
      SplineSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.temperature ?? 0,
        sortFieldValueMapper: (Records d, _) => d.createdAt,
        sortingOrder: SortingOrder.ascending,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'Temp',
      ),
    ];
  }

  List<SplineSeries<Records, DateTime>>? getSpineMoistureData() {
    return <SplineSeries<Records, DateTime>>[
      SplineSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.moisture ?? 0,
        sortFieldValueMapper: (Records d, _) => d.createdAt,
        sortingOrder: SortingOrder.ascending,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'Moisture',
        color: Colors.lightBlue,
      ),
    ];
  }

  List<AreaSeries<Records, DateTime>>? getAreaMoistureData() {
    return <AreaSeries<Records, DateTime>>[
      AreaSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.moisture ?? 0,
        sortFieldValueMapper: (Records d, _) => d.createdAt,
        sortingOrder: SortingOrder.ascending,
        //markerSettings: const MarkerSettings(isVisible: true),
        name: 'Moisture: ${deviceRecords![0].moisture}%',
        //legendItemText: 'Moisture',
        color: Colors.lightBlue,
        //color: Color.fromRGBO(247, 147, 29, .8),
      ),
    ];
  }

  List<SplineSeries<Records, DateTime>>? getSpineVpdData() {
    return <SplineSeries<Records, DateTime>>[
      SplineSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.vpd ?? 0,
        sortFieldValueMapper: (Records d, _) => d.createdAt,
        sortingOrder: SortingOrder.ascending,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'VPD: ${deviceRecords![0].vpd} kPa',
        //legendItemText: 'VPD',
        color: Colors.green,
      ),
    ];
  }

  List<AreaSeries<Records, DateTime>>? getAreaHumidData() {
    return <AreaSeries<Records, DateTime>>[
      AreaSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.humidity ?? 0,
        //markerSettings: const MarkerSettings(isVisible: true),
        name: 'Humidity: ${deviceRecords![0].humidity}',
        //legendItemText: 'Humidity%',
        color: Colors.green,
      ),
    ];
  }

  List<AreaSeries<Records, DateTime>>? getAreaBattData() {
    return <AreaSeries<Records, DateTime>>[
      AreaSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.batt ?? 0,
        //markerSettings: const MarkerSettings(isVisible: true),
        name: 'Battery: ${deviceRecords![0].batt}%',
        //legendItemText: 'Battery%',
        color: Colors.green,
      ),
    ];
  }

  List<SplineAreaSeries<Records, DateTime>>? getAreaHumidAndTempData() {
    return <SplineAreaSeries<Records, DateTime>>[
      SplineAreaSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.temperature ?? 0,
        sortFieldValueMapper: (Records d, _) => d.createdAt,
        sortingOrder: SortingOrder.ascending,
        //markerSettings: const MarkerSettings(isVisible: true),
        name: 'Temp: ${deviceRecords![0].temperature}°F',
        color: Color.fromRGBO(255, 140, 0, 0.4), //orange
        splineType: SplineType.cardinal,
      ),
      SplineAreaSeries<Records, DateTime>(
        dataSource: deviceRecords!,
        xValueMapper: (Records d, _) => d.getGraphTime(),
        yValueMapper: (Records d, _) => d.humidity ?? 0,
        //markerSettings: const MarkerSettings(isVisible: true),
        name: 'Humidity: ${deviceRecords![0].humidity}%',
        //legendItemText: 'Humidity (%)',
        color: Color.fromRGBO(127, 255, 0, 0.4), // chartreuse - cause why the fuck not
        splineType: SplineType.cardinal,
      ),
    ];
  }
}

class Devices {
  int? id;
  int? userId;
  String? hostname;
  String? createdAt;
  String? updatedAt;

  Devices(
      {this.id, this.userId, this.hostname, this.createdAt, this.updatedAt});

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    hostname = json['hostname'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['hostname'] = this.hostname;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

