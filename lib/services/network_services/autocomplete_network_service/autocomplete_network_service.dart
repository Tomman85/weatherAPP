import 'package:dio/dio.dart';
import 'package:weather/main.dart';
import 'package:weather/services/config_reader/config_reader.dart';

class AutocompleteNetworkService {
  static Future<Response> getAutocompletePrediction(name, lang) async {
    String autocompleteApiKey = ConfigReader.getAutocompleteKey();
    Response response = await networkService.get(
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$name&format=json&lang=$lang&apiKey=$autocompleteApiKey');

    return response;
  }
}
