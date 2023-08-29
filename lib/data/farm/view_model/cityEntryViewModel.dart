import 'package:geolocator/geolocator.dart';
import 'package:plantpulse/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CityEntryViewModel with ChangeNotifier {
  String _city = '';

  CityEntryViewModel();

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false).getLatestWeather(_city as Position);

    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}
