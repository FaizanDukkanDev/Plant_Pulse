class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

class WeatherData {
  final String cityName;
  final double temperature;
  final int humidity;
  final int pressure;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.pressure,
  });
}

class WeatherResponse {
  final Location location;
  final WeatherData weatherData;

  WeatherResponse({
    required this.location,
    required this.weatherData,
  });
}