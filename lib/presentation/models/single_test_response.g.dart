// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_test_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleTestResponse _$SingleTestResponseFromJson(Map<String, dynamic> json) =>
    SingleTestResponse(
      TestModel.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleTestResponseToJson(SingleTestResponse instance) =>
    <String, dynamic>{
      'results': instance.testModel,
    };
