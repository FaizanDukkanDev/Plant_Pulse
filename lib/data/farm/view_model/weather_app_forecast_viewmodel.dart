import 'dart:core';

import 'package:plantpulse/data/farm/api/openweathermap_weather_api.dart';
import 'package:plantpulse/data/farm/models/Forecast.dart';
import 'package:plantpulse/data/farm/models/Weather.dart';
import 'package:plantpulse/data/farm/models/WeatherResponse.dart';
import 'package:plantpulse/data/farm/services/forecast_service.dart';
import 'package:plantpulse/data/farm/utils/WeatherIconMapper.dart';
import 'package:plantpulse/data/farm/utils/weather_strings.dart';
import 'package:plantpulse/data/farm/utils/weather_temp.dart';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  WeatherCondition? _condition;
  String? _description;
  String? _iconCode;
  //IconData? _iconData;
  double? _minTemp;
  double? _maxTemp;
  double? _temp;
  double? _feelsLike;
  int? _locationId;
  DateTime? _lastUpdated;
  String? _city;
  double? _latitude;
  double? _longitude;
  List<Weather>? _daily;
  bool? _isDayTime;

  WeatherCondition get condition => _condition ?? WeatherCondition.clear;
  IconData get iconData => getIconData(_iconCode ?? '');
  String get description => _description ?? '';
  String get iconCode => _iconCode ?? '';
  double get minTemp => _minTemp ?? 0.0;
  double get maxTemp => _maxTemp ?? 0.0;
  double get temp => _temp ?? 0.0;
  double get feelsLike => _feelsLike ?? 0.0;
  int get locationId => _locationId ?? 0;
  DateTime get lastUpdated => _lastUpdated ?? DateTime.now();
  String get city => _city ?? '';
  double get longitude => _longitude ?? 0.0;
  double get latitide => _latitude ?? 0.0;
  bool get isDaytime => _isDayTime ?? false;
  List<Weather> get daily => _daily ?? [];

  late ForecastService forecastService;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
  }

  Future<Forecast> getLatestWeather(Position position) async {
    setRequestPendingState(true);
    this.isRequestError = false;
    //position.toString()
    late Forecast latest;
    late WeatherResponse weatherResponse;
    try {
      await Future.delayed(Duration(seconds: 1), () => {});
      latest = await forecastService.getWeather(position);
      weatherResponse = await forecastService.fetchWeatherData(position);
      latest.city = weatherResponse.weatherData.cityName;
      //latest.city = weatherResponse.c
    } catch (e) {
      this.isRequestError = true;
    }

    this.isWeatherLoaded = true;
    updateModel(latest, position);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, Position position) {
    if (isRequestError) {
      _daily = null;
      return;
    }

    _condition = forecast.current.condition;
    //_city = forecast.city;
    _iconCode = forecast.current.iconCode;

    _description = Strings.toTitleCase(forecast.current.description);
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToFarenheit(forecast.current.temp);
    _feelsLike = TemperatureConvert.kelvinToFarenheit(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
    _city = forecast.city;
  }

  IconData getIconData(String iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}