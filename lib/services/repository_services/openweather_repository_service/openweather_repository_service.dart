import 'package:dio/dio.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:weather/services/network_services/openweather_network_service/openweather_network_service.dart';

class OpenweatherRepositoryService {
  static Future<ListWeatherDataModel?> getOpenweatherData(lat, lon,lang) async {
    try {
      Response response =
          await OpenweatherNetworkService.getOpenweatherData(lat, lon,lang);
      return ListWeatherDataModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
