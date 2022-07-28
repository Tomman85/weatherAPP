
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

Widget buildChild(int id, width, height) {
  if (id >= 200 && id < 250) {
    return WeatherBg(
        weatherType: WeatherType.thunder, width: width, height: height);
  } else if (id >= 300 && id < 350 || id == 500) {
    return WeatherBg(
        weatherType: WeatherType.lightRainy, width: width, height: height);
  } else if (id > 500 && id <= 550) {
    return WeatherBg(
        weatherType: WeatherType.heavyRainy, width: width, height: height);
  } else if (id == 600) {
    return WeatherBg(
        weatherType: WeatherType.lightSnow, width: width, height: height);
  } else if (id >= 601 && id <= 650) {
    return WeatherBg(
        weatherType: WeatherType.heavySnow, width: width, height: height);
  } else if (id == 731) {
    return WeatherBg(
        weatherType: WeatherType.dusty, width: width, height: height);
  } else if (id == 721) {
    return WeatherBg(
        weatherType: WeatherType.hazy, width: width, height: height);
  } else if (id > 700 && id <= 781) {
    return WeatherBg(
        weatherType: WeatherType.foggy, width: width, height: height);
  } else if (id == 801 || id == 802) {
    return WeatherBg(
        weatherType: WeatherType.cloudy, width: width, height: height);
  } else if (id == 803 && id == 804) {
    return WeatherBg(
        weatherType: WeatherType.overcast, width: width, height: height);
  }
  return WeatherBg(
      weatherType: WeatherType.sunny, width: width, height: height);
}
