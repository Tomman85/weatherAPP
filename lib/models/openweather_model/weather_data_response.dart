import 'package:json_annotation/json_annotation.dart';

import 'daily_data_model.dart';
import 'weather_model.dart';

part 'weather_data_response.g.dart';

@JsonSerializable()
class ListWeatherDataModel {
  @JsonKey(name: 'current')
  WeatherModel currentWeatherModel;

  @JsonKey(name: 'hourly')
  List<WeatherModel> hourlyWeatherModel;

  @JsonKey(name: 'daily')
  List<DailyDataModel> dailyWeatherModel;

  @JsonKey(name: "timezone_offset")
  int? timeOffset;

  ListWeatherDataModel({
    required this.currentWeatherModel,
    required this.hourlyWeatherModel,
    required this.dailyWeatherModel,
  });

  factory ListWeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$ListWeatherDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListWeatherDataModelToJson(this);
}
