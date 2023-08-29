import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class TelemetryData {
  const TelemetryData({required this.timestamp, required this.value});

  final DateTime timestamp;
  final String value;

  factory TelemetryData.fromRealtimeDatabase(DataSnapshot data) {
    debugPrint('LOG : $data');
    return TelemetryData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(data.key!)),
      value: data.value as String,
    );
  }

  factory TelemetryData.from(String timestamp, String value) {
    return TelemetryData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)),
      value: value,
    );
  }
}
