
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/models/autocomplete_model/list_response.dart';
import 'package:weather/services/network_services/autocomplete_network_service/autocomplete_network_service.dart';

class AutocompleteRepositoryService {
  static Future<ListPredictionsData?> getAutocompletePrediction(String name, String lang) async {
    try {
      Response response = await AutocompleteNetworkService.getAutocompletePrediction(name, lang);


      return ListPredictionsData.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}