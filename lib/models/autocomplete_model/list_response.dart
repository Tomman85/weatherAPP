import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/autocomplete_model/prediction_model.dart';

part 'list_response.g.dart';

@JsonSerializable()
class ListPredictionsData{
  @JsonKey(name:'results')
  List<PredictionModel> predictionModel;

  ListPredictionsData({required this.predictionModel});

  factory ListPredictionsData.fromJson(Map<String, dynamic> json) =>
      _$ListPredictionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ListPredictionsDataToJson(this);
}