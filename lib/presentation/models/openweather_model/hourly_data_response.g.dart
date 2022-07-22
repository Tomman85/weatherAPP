// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListHourlyModelData _$ListHourlyModelDataFromJson(Map<String, dynamic> json) =>
    ListHourlyModelData(
      hourlyWeatherModel: (json['hourly'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListHourlyModelDataToJson(
        ListHourlyModelData instance) =>
    <String, dynamic>{
      'hourly': instance.hourlyWeatherModel,
    };
