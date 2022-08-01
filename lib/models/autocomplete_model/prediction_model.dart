import 'package:json_annotation/json_annotation.dart';

part 'prediction_model.g.dart';

@JsonSerializable()
class PredictionModel {
  String? city;
  String? formatted;
  String? country;
  @JsonKey(name: "lon")
  double? longitude;
  @JsonKey(name: "lat")
  double? latitude;

  PredictionModel({
    required this.city,
    required this.country,
    required this.longitude,
    required this.latitude,
    required this.formatted,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      _$PredictionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}
