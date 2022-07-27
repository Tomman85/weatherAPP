// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDataModel _$DailyDataModelFromJson(Map<String, dynamic> json) =>
    DailyDataModel()
      ..temperature = (json['temp'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      )
      ..currentTime = json['dt'] as int?
      ..sunrise = json['sunrise'] as int?
      ..sunset = json['sunset'] as int?
      ..pressure = (json['pressure'] as num?)?.toDouble()
      ..humidity = (json['humidity'] as num?)?.toDouble()
      ..clouds = (json['clouds'] as num?)?.toDouble()
      ..windSpeed = (json['wind_speed'] as num?)?.toDouble()
      ..windDegree = (json['wind_deg'] as num?)?.toDouble()
      ..uv = (json['uvi'] as num?)?.toDouble()
      ..timeOffset = json['timezone_offset'] as int?
      ..weatherDescription = (json['weather'] as List<dynamic>?)
          ?.map((e) =>
              WeatherDescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DailyDataModelToJson(DailyDataModel instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'dt': instance.currentTime,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'clouds': instance.clouds,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDegree,
      'uvi': instance.uv,
      'timezone_offset': instance.timeOffset,
      'weather': instance.weatherDescription,
    };
