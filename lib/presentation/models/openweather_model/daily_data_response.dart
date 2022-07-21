import 'package:json_annotation/json_annotation.dart';

import 'weather_model.dart';

part 'daily_data_response.g.dart';

@JsonSerializable()
class ListDailyModelData {

  @JsonKey(name: 'daily')
  List<WeatherModel>? dailyWeatherModel;

  ListDailyModelData({
    required this.dailyWeatherModel,
  });

  factory ListDailyModelData.fromJson(Map<String, dynamic> json) =>
      _$ListDailyModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListDailyModelDataToJson(this);
}
