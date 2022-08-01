// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPredictionsData _$ListPredictionsDataFromJson(Map<String, dynamic> json) =>
    ListPredictionsData(
      predictionModel: (json['results'] as List<dynamic>)
          .map((e) => PredictionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListPredictionsDataToJson(
        ListPredictionsData instance) =>
    <String, dynamic>{
      'results': instance.predictionModel,
    };
