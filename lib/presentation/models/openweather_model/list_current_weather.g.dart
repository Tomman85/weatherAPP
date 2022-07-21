// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      temperature: (json['temp'] as num?)?.toDouble(),
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'wind_speed': instance.windSpeed,
    };
