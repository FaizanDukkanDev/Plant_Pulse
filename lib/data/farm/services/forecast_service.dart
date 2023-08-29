import 'package:plantpulse/data/farm/models/Forecast.dart';
import 'package:plantpulse/data/farm/services/weather_api.dart';
import 'package:plantpulse/data/farm/models/WeatherResponse.dart';
import 'package:geolocator/geolocator.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(Position position) async {
    final weather = await weatherApi.getWeather(position);
    return weather;
  }

  Future<WeatherResponse> fetchWeatherData(Position position) async {
    final weather = await weatherApi.fetchWeatherData(position);
    return weather;
  }

/*Future<Location> getLocation(Position position) async {
    final location = await weatherApi.getLocation(position);
    return location;
  }*/
}
