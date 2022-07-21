// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_openweather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModelData _$ListModelDataFromJson(Map<String, dynamic> json) =>
    ListModelData()
      ..currentWeatherModel = json['current'] == null
          ? null
          : WeatherModel.fromJson(json['current'] as Map<String, dynamic>)
      ..hourlyWeatherModel = (json['hourly'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..dailyWeatherModel = (json['daily'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ListModelDataToJson(ListModelData instance) =>
    <String, dynamic>{
      'current': instance.currentWeatherModel,
      'hourly': instance.hourlyWeatherModel,
      'daily': instance.dailyWeatherModel,
    };
