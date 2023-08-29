import 'package:plantpulse/data/farm/models/Weather.dart';
import 'package:plantpulse/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:plantpulse/data/farm/utils/weather_temp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherSummary extends StatelessWidget {
  final ForecastViewModel model;
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;
  final IconData iconData;
  final String city;
  final String description;
  List<Weather> daily;

  WeatherSummary({
    Key? key,
    required this.model,
    required this.condition,
    required this.temp,
    required this.feelsLike,
    required this.isdayTime,
    required this.iconData,
    required this.city,
    required this.description,
    required this.daily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    this.city,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${_formatTemperature(this.temp)}°F',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Feels like ${_formatTemperature(this.feelsLike)}°F',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Icon(
                  iconData,
                  size: 60.0,
                ),
              ),
              Text(
                this.description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < daily.length && i < 5; i++)
                Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //textAlign: TextAlign.center,
                        '${_formatTemperature(TemperatureConvert.kelvinToFarenheit(daily[i].temp))}°F',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 6.0),
                        //alignment: Alignment.center,
                        //alignment: AlignmentDirectional.center,
                        child: new Icon(
                          color: Colors.white,
                          //iconData,
                          daily[i].getIconData(daily[i].iconCode),
                          size: 15,
                        ),
                      ),
                      Text(
                        '${_getDayOfWeek(daily[i].date.toString())}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String day = DateFormat('EEEE').format(date);
    return day;
  }

  String _formatTemperature(double t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/images/thunder_storm.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy.png');
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? image = Image.asset('assets/images/light_cloud.png')
            : image = Image.asset('assets/images/light_cloud-night.png');
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset('assets/images/drizzle.png');
        break;
      case WeatherCondition.clear:
        isDayTime
            ? image = Image.asset('assets/images/clear.png')
            : image = Image.asset('assets/images/clear-night.png');
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/images/fog.png');
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow.png');
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rain.png');
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset('assets/images/fog.png');
        break;

      default:
        image = Image.asset('assets/images/unknown.png');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}