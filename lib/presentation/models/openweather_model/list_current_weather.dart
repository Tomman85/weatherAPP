import 'package:json_annotation/json_annotation.dart';

part 'list_current_weather.g.dart';

@JsonSerializable()
class CurrentWeatherModel{
  @JsonKey(name: "temp")
  double? temperature;

  @JsonKey(name: "wind_speed")
  double? windSpeed;

  CurrentWeatherModel({required this.temperature,required this.windSpeed});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);

}