import 'package:plantpulse/data/farm/models/Forecast.dart';
import 'package:plantpulse/data/farm/models/Weather.dart';
import 'package:plantpulse/data/farm/view_model/cityEntryViewModel.dart';
import 'package:plantpulse/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:plantpulse/ui/farm/weather/weatherSummaryView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'cityEntryView.dart';
import 'gradient.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      refreshWeather(Provider.of<ForecastViewModel>(context, listen: false), context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Container(
        child: _buildGradientContainer(
            model.condition, model.isDaytime, buildHomeView(context, model)),
      ),
    );

  }

  @override
  Widget buildHomeView(BuildContext context, model) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => Container(
            height: 250,
            child: RefreshIndicator(
              color: Colors.transparent,
              backgroundColor: Colors.transparent,
              onRefresh: () =>  refreshWeather(weatherViewModel, context),
              child: ListView(
                children: <Widget>[
                  if (!weatherViewModel.isWeatherLoaded) CityEntryView(), // if weatherViewModel.city is empty hide
                  weatherViewModel.isRequestPending
                      ? buildBusyIndicator()
                      : weatherViewModel.isRequestError
                      ? Center(
                      child: Text('Ooops...something went wrong',
                          style: TextStyle(fontSize: 21, color: Colors.white)))
                      : Column(children: [
                    WeatherSummary(
                      condition: weatherViewModel.condition,
                      temp: weatherViewModel.temp,
                      feelsLike: weatherViewModel.feelsLike,
                      isdayTime: weatherViewModel.isDaytime,
                      iconData: weatherViewModel.iconData,
                      city: weatherViewModel.city,
                      description: weatherViewModel.description,
                      daily: weatherViewModel.daily,
                      model: model,
                      // weatherModel: model,
                    ),
                  ]),
                ],
              ),
            )));
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Loading weather...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Future<void> refreshWeather(ForecastViewModel weatherVM, BuildContext context) {
    // check permissions and return lat/lng if permission allowed
    final weather = _checkLocationPermission(weatherVM, context);
    // get the current city
    //Position position;
    //String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    return weather;
  }

  Future<void> _checkLocationPermission(ForecastViewModel weatherVM, BuildContext context) async {
    PermissionStatus permission = await Permission.locationWhenInUse.status;
    if (permission.isDenied) {
      _showPermissionDeniedMessage(weatherVM);
      //await _requestLocationPermission(weatherVM, context);
    } else if (permission.isPermanentlyDenied) {
      _showPermissionDeniedForeverMessage();
    } else {
      _getLocation(weatherVM, context);
    }
  }

  Future<void> _requestLocationPermission(ForecastViewModel weatherVM, BuildContext context) async {
    PermissionStatus permission = await Permission.locationWhenInUse.request();
    if (permission.isGranted) {
      _getLocation(weatherVM, context);
    }
  }

  Future<Forecast> _getLocation(ForecastViewModel weatherVM, BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return weatherVM.getLatestWeather(position);
  }

  void _showPermissionDeniedMessage(ForecastViewModel weatherVM) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GPS Permission Denied'),
          content: Text(
              'GPS permission is necessary to get accurate weather readings. Please tap OK to grant GPS permission'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _requestLocationPermission(weatherVM, context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedForeverMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GPS Permission Denied Forever'),
          content: Text(
              'GPS permission is necessary to get accurate weather readings. Please grant the permission in the app settings.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (!isDayTime)
      container = GradientContainer(color: Colors.blueGrey, child: child);
    else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}