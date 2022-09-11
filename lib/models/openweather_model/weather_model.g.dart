// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      temperature: (json['temp'] as num?)?.toDouble(),
    )
      ..currentTime = json['dt'] as int?
      ..sunrise = json['sunrise'] as int?
      ..sunset = json['sunset'] as int?
      ..feelTemperature = (json['feels_like'] as num?)?.toDouble()
      ..pressure = (json['pressure'] as num?)?.toDouble()
      ..humidity = (json['humidity'] as num?)?.toDouble()
      ..clouds = (json['clouds'] as num?)?.toDouble()
      ..windDegree = (json['wind_deg'] as num?)?.toDouble()
      ..uv = (json['uvi'] as num?)?.toDouble()
      ..weatherDescription = (json['weather'] as List<dynamic>?)
          ?.map((e) =>
              WeatherDescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'dt': instance.currentTime,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'feels_like': instance.feelTemperature,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'clouds': instance.clouds,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDegree,
      'uvi': instance.uv,
      'weather': instance.weatherDescription,
    };
