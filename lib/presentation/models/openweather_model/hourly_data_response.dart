import 'package:json_annotation/json_annotation.dart';

import 'weather_model.dart';

part 'hourly_data_response.g.dart';

@JsonSerializable()
class ListHourlyModelData {
  @JsonKey(name: 'hourly')
  List<WeatherModel>? hourlyWeatherModel;

  ListHourlyModelData({
    required this.hourlyWeatherModel,
  });

  factory ListHourlyModelData.fromJson(Map<String, dynamic> json) =>
      _$ListHourlyModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListHourlyModelDataToJson(this);
}
