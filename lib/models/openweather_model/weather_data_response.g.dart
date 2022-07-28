// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListWeatherDataModel _$ListWeatherDataModelFromJson(
        Map<String, dynamic> json) =>
    ListWeatherDataModel(
      currentWeatherModel:
          WeatherModel.fromJson(json['current'] as Map<String, dynamic>),
      hourlyWeatherModel: (json['hourly'] as List<dynamic>)
          .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyWeatherModel: (json['daily'] as List<dynamic>)
          .map((e) => DailyDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..timeOffset = json['timezone_offset'] as int?;

Map<String, dynamic> _$ListWeatherDataModelToJson(
        ListWeatherDataModel instance) =>
    <String, dynamic>{
      'current': instance.currentWeatherModel,
      'hourly': instance.hourlyWeatherModel,
      'daily': instance.dailyWeatherModel,
      'timezone_offset': instance.timeOffset,
    };
