// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCurrentModelData _$ListCurrentModelDataFromJson(
        Map<String, dynamic> json) =>
    ListCurrentModelData(
      currentWeatherModel:
          WeatherModel.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListCurrentModelDataToJson(
        ListCurrentModelData instance) =>
    <String, dynamic>{
      'current': instance.currentWeatherModel,
    };
