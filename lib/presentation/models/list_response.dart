import 'package:json_annotation/json_annotation.dart';
import 'package:weather/presentation/models/test_model.dart';

part 'list_response.g.dart';

@JsonSerializable()
class ListDataResponse{
  @JsonKey(name:'results')
  List<TestModel> testModel;

  ListDataResponse({required this.testModel});

  factory ListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ListDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListDataResponseToJson(this);
}