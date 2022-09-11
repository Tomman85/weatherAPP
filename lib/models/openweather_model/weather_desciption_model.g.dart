// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_desciption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDescriptionModel _$WeatherDescriptionModelFromJson(
        Map<String, dynamic> json) =>
    WeatherDescriptionModel(
      id: json['id'] as int,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherDescriptionModelToJson(
        WeatherDescriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icon': instance.icon,
    };
