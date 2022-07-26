import 'package:dio/dio.dart';
import 'package:weather/credentials.dart';
import 'package:weather/main.dart';

class AutocompleteNetworkService {
  static Future<Response> getAutocompletePrediction(name,lang) async {
    Response response = await networkService.get(
      'https://api.geoapify.com/v1/geocode/autocomplete?text=$name&format=json&lang=$lang&apiKey=$autocompleteApi');

    return response;
  }
}
