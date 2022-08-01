import 'package:json_annotation/json_annotation.dart';

part 'weather_desciption_model.g.dart';

@JsonSerializable()
class WeatherDescriptionModel {
  int id;
  String description;
  String icon;

  WeatherDescriptionModel({
    required this.id,
    required this.description,
    required this.icon,
  });

  factory WeatherDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDescriptionModelToJson(this);
}
