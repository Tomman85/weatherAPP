import 'package:json_annotation/json_annotation.dart';

part 'daily_data_model.g.dart';

@JsonSerializable()
class DailyDataModel {
  @JsonKey(name: "temp")
  Map<String, double> temperature;

  @JsonKey(name: "wind_speed")
  double? windSpeed;

  DailyDataModel({
    required this.windSpeed,
    required this.temperature,
  });

  factory DailyDataModel.fromJson(Map<String, dynamic> json) =>
      _$DailyDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyDataModelToJson(this);
}
