import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ReloadTime extends ChangeNotifier {
  String _reloadTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

  String get reloadTime => _reloadTime;

  void update(DateTime timestamp) {
    _reloadTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(timestamp);
    notifyListeners();
  }
}
