import 'package:weather/domain/weather/data/city_prediction.dart';

abstract class CityAutocompleteRepository {
  Future<List<CityPrediction>> getPredictions(String name);
}