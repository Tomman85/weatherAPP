// import 'package:weather/data/weather/data_sources/remote_google_data_source.dart';
// import 'package:weather/data/weather/mappers/prediction_dto_to_city_prediction_mapper.dart';
// import 'package:weather/domain/weather/data/city_prediction.dart';
// import 'package:weather/domain/weather/repository/city_autocomplete_repository.dart';
//
// class RemoteCityAutocompleteRepository implements CityAutocompleteRepository {
//
//   final RemoteGoogleAutocompleteSource _dataSource;
//   final PredictionDtoToPredictionMapper _predictionMapper;
//
//   RemoteCityAutocompleteRepository(this._dataSource, this._predictionMapper);
//
//   @override
//   Future<List<CityPrediction>> getPredictions(String name) async {
//     final predictionsDto = await _dataSource.getListOfCities(name);
//
//     final List<CityPrediction> predictions = [];
//
//     for(final singlePrediction in predictionsDto.predictions){
//       predictions.add(_predictionMapper.map(singlePrediction));
//     }
//
//     return predictions;
//
//   }
//
// }