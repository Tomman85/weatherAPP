// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionModel _$PredictionModelFromJson(Map<String, dynamic> json) =>
    PredictionModel(
      city: json['city'] as String?,
      country: json['country'] as String?,
      longitude: (json['lon'] as num?)?.toDouble(),
      latitude: (json['lat'] as num?)?.toDouble(),
      formatted: json['formatted'] as String?,
    );

Map<String, dynamic> _$PredictionModelToJson(PredictionModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'formatted': instance.formatted,
      'country': instance.country,
      'lon': instance.longitude,
      'lat': instance.latitude,
    };
