// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDataModel _$DailyDataModelFromJson(Map<String, dynamic> json) =>
    DailyDataModel(
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      temperature: (json['temp'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$DailyDataModelToJson(DailyDataModel instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'wind_speed': instance.windSpeed,
    };
