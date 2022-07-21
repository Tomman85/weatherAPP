import 'package:json_annotation/json_annotation.dart';

import 'list_current_weather.dart';

part 'list_openweather_response.g.dart';

@JsonSerializable()
class ListModelData {
  @JsonKey(name: 'current')
  WeatherModel? currentWeatherModel;

  @JsonKey(name: 'hourly')
  List<WeatherModel>? hourlyWeatherModel;

  @JsonKey(name: 'daily')
  List<WeatherModel>? dailyWeatherModel;



  ListModelData();

  factory ListModelData.fromJson(Map<String, dynamic> json) =>
      _$ListModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListModelDataToJson(this);
}
