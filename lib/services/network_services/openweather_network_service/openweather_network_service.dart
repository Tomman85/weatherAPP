import 'package:dio/dio.dart';
import 'package:weather/credentials.dart';
import 'package:weather/main.dart';

class OpenweatherNetworkService {
  static Future<Response> getOpenweatherData(lat, lon,lang) async {
    Response response = await networkService.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&lang=$lang&units=metric&appid=$openWeatherApi");
    return response;
  }
}
