import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  @JsonKey(name: "temp")
  double? temperature;
  @JsonKey(name: "dt")
  int? currentTime;
  int? sunrise;
  int? sunset;
  @JsonKey(name: "feels_like")
  double? feelTemperature;
  double? pressure;
  double? humidity;
  double? clouds;
  @JsonKey(name: "wind_speed")
  double? windSpeed;
  @JsonKey(name: "wind_deg")
  double? windDegree;
  @JsonKey(name: "uvi")
  double? uv;

  WeatherModel({required this.windSpeed, required this.temperature});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
