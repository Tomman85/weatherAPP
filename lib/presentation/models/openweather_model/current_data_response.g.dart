// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDailyModelData _$ListDailyModelDataFromJson(Map<String, dynamic> json) =>
    ListDailyModelData(
      currentWeatherModel: (json['current'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDailyModelDataToJson(ListDailyModelData instance) =>
    <String, dynamic>{
      'current': instance.currentWeatherModel,
    };
