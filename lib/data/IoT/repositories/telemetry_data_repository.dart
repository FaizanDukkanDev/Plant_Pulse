import 'package:plantpulse/data/IoT/models/telemetry_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TelemetryDataRepository {
  TelemetryDataRepository() {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    firebaseDatabase.setPersistenceEnabled(true);
    _telemetryDb = firebaseDatabase.ref().child('telemetry_data').child(
          FirebaseAuth.instance.currentUser!.uid,
        );
  }

  late DatabaseReference _telemetryDb;

  Stream<TelemetryData> readData(String data) {
    return _telemetryDb
        .child("telemetry_data/d2fgriJiJFa3xlDESTD0nQ7AbRD2/" + data)
        .orderByKey()
        .onChildAdded
        .map((event) => TelemetryData.fromRealtimeDatabase(event.snapshot));
  }

  Future<List<TelemetryData>> readPrevReadings(String data, int num) async {
    List<TelemetryData> dataList = [];
    DatabaseEvent event = await _telemetryDb.child(data).orderByKey().limitToLast(num).once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> map = event.snapshot.value as Map<dynamic, dynamic>;
      map.entries.toList()
        ..sort((d1, d2) => int.parse(d1.key).compareTo(int.parse(d2.key)))
        ..forEach((d) => dataList.add(TelemetryData.from(d.key, d.value)));
    }
    return dataList;
  }
}
