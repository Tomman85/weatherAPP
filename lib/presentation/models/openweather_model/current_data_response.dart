import 'package:json_annotation/json_annotation.dart';

import 'weather_model.dart';

part 'current_data_response.g.dart';

@JsonSerializable()
class ListDailyModelData {

  @JsonKey(name: 'current')
  List<WeatherModel>? currentWeatherModel;

  ListDailyModelData({
    required this.currentWeatherModel,
  });

  factory ListDailyModelData.fromJson(Map<String, dynamic> json) =>
      _$ListDailyModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListDailyModelDataToJson(this);
}
