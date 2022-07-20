// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_openweather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModelData _$ListModelDataFromJson(Map<String, dynamic> json) =>
    ListModelData(
      currentWeatherModel: (json['hourly'] as List<dynamic>)
          .map((e) => CurrentWeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListModelDataToJson(ListModelData instance) =>
    <String, dynamic>{
      'hourly': instance.currentWeatherModel,
    };
