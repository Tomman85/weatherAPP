import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  @JsonKey(name: "temp")
  double? temperature;

  @JsonKey(name: "wind_speed")
  double? windSpeed;

  WeatherModel({required this.temperature,required this.windSpeed});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

}