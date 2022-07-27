import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/openweather_model/weather_desciption_model.dart';

part 'daily_data_model.g.dart';

@JsonSerializable()
class DailyDataModel {
  @JsonKey(name: "temp")
  Map<String, double>? temperature;

  @JsonKey(name: "dt")
  int? currentTime;
  int? sunrise;
  int? sunset;

  double? pressure;
  double? humidity;
  double? clouds;
  @JsonKey(name: "wind_speed")
  double? windSpeed;
  @JsonKey(name: "wind_deg")
  double? windDegree;
  @JsonKey(name: "uvi")
  double? uv;
  @JsonKey(name: "timezone_offset")
  int? timeOffset;

  @JsonKey(name: "weather")
  List<WeatherDescriptionModel>? weatherDescription;

  DailyDataModel();

  factory DailyDataModel.fromJson(Map<String, dynamic> json) =>
      _$DailyDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyDataModelToJson(this);
}
