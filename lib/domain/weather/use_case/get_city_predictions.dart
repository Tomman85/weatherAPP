import 'package:weather/domain/weather/data/city_prediction.dart';
import 'package:weather/domain/weather/repository/city_autocomplete_repository.dart';

class GetCityPredictionsUseCase {
  final CityAutocompleteRepository _repository;

  GetCityPredictionsUseCase(this._repository);

  Future<List<CityPrediction>> call(String name) => _repository. getPredictions(name);
}