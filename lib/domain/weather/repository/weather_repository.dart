

import 'package:weather/domain/weather/data/weather.dart';

abstract class WeatherRepository{
  Future<Weather> getCurrentWeather(String cityName);
}