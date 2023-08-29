import 'dart:convert';

import 'package:plantpulse/data/farm/models/Forecast.dart';
import 'package:plantpulse/data/farm/models/WeatherResponse.dart';
import 'package:plantpulse/data/farm/services/weather_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const addyEndPointUrl = 'http://api.openweathermap.org/geo/1.0';
  static const apiKey = "150e1f904ffc6f8fbccb17e44bc6e76f";
  late http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    this.httpClient = http.Client();
  }

  /*Future<Location> getLocation(Position position) async {
    final requestUrl = '$addyEndPointUrl/reverse?lat=${position.latitude}&lon=${position.longitude}&APPID=$apiKey';
    //final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving location for position $position: ${response.statusCode}');
    }
    return Location.fromJson(jsonDecode(response.body));
  }*/

  @override
  Future<Forecast> getWeather(Position position) async {

    final requestUrl =
        '$endPointUrl/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly,minutely&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }
    return Forecast.fromJson(jsonDecode(response.body));
  }

  @override
  Future<WeatherResponse> fetchWeatherData(Position position) async {
    //const apiKey = "150e1f904ffc6f8fbccb17e44bc6e76f";
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=' + position.latitude.toString() + '&lon=' + position.longitude.toString() + '&appid=' + apiKey;

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      final cityName = jsonBody['name'];
      final temperature = jsonBody['main']['temp'];
      final humidity = jsonBody['main']['humidity'];
      final pressure = jsonBody['main']['pressure'];

      final weatherData = WeatherData(
        cityName: cityName,
        temperature: temperature,
        humidity: humidity,
        pressure: pressure,
      );

      final location = Location(latitude: position.latitude, longitude: position.longitude);

      return WeatherResponse(
        location: location,
        weatherData: weatherData,
      );
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}