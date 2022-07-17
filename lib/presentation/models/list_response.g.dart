// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDataResponse _$ListDataResponseFromJson(Map<String, dynamic> json) =>
    ListDataResponse(
      testModel: (json['results'] as List<dynamic>)
          .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDataResponseToJson(ListDataResponse instance) =>
    <String, dynamic>{
      'results': instance.testModel,
    };
