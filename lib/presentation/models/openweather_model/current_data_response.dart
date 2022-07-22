import 'package:json_annotation/json_annotation.dart';

import 'weather_model.dart';

part 'current_data_response.g.dart';

@JsonSerializable()
class ListCurrentModelData {

  @JsonKey(name: 'current')
  WeatherModel currentWeatherModel;

  ListCurrentModelData({
    required this.currentWeatherModel,
  });

  factory ListCurrentModelData.fromJson(Map<String, dynamic> json) =>
      _$ListCurrentModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListCurrentModelDataToJson(this);
}
