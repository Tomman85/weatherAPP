// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
      longitude: json['longitude'] as String,
      latitude: json['lat'] as String,
      val: json['val'] as int,
    );

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'val': instance.val,
      'lat': instance.latitude,
    };
