import 'package:dio/dio.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:weather/services/network_services/openweather_network_service/openweather_network_service.dart';

class OpenweatherRepositoryService {
  static Future<ListWeatherDataModel?> getOpenweatherData(lat, lon) async {
    try {
      Response response =
          await OpenweatherNetworkService.getOpenweatherData(lat, lon);
      return ListWeatherDataModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
