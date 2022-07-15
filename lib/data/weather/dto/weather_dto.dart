import 'package:json_annotation/json_annotation.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto {
  String longitude;
  int val;
  @JsonKey(name: 'lat')
  String latitude;

  WeatherDto({required this.longitude, required this.latitude, required this.val});

  factory WeatherDto.fromJson(Map<String, dynamic> json) => _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);
}
