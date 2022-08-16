import 'package:dio/dio.dart';
import 'package:weather/main.dart';
import 'package:weather/services/config_reader/config_reader.dart';

class OpenweatherNetworkService {
  static Future<Response> getOpenweatherData(lat, lon,lang) async {
    String apiKey = ConfigReader.getOpenWeatherKey();
    Response response = await networkService.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&lang=$lang&units=metric&appid=$apiKey");
    return response;
  }
}
